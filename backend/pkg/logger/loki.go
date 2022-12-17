package logger

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"singkatinaja/internal/delivery/payload"

	"github.com/afiskon/promtail-client/promtail"
	"github.com/golang-jwt/jwt"
	"github.com/labstack/echo/v4"
)

type loki struct {
	client promtail.Client
}

func newLoki(fnOpt ...FnOpt) (Logger, error) {

	options := new(Options)
	options.Default()

	for _, o := range fnOpt {
		err := o(options)
		if err != nil {
			return nil, err
		}
	}

	labels := fmt.Sprintf(`{source="%s",env="%s"}`, options.LokiConfig.Source, options.LokiConfig.Env)

	conf := promtail.ClientConfig{
		PushURL:            options.LokiConfig.Url,
		Labels:             labels,
		BatchWait:          5 * time.Second,
		BatchEntriesNumber: 10000,
		SendLevel:          promtail.LogLevel(options.SendLevel),
		PrintLevel:         promtail.LogLevel(options.PrintLevel),
	}

	client, err := promtail.NewClientJson(conf)
	if err != nil {
		return nil, err
	}

	return &loki{
		client: client,
	}, nil
}

func (l *loki) Debugf(format string, args ...interface{}) {
	l.client.Debugf(format, args...)
}

func (l *loki) Infof(format string, args ...interface{}) {
	l.client.Infof(format, args...)
}

func (l *loki) Warnf(format string, args ...interface{}) {
	l.client.Warnf(format, args...)
}

func (l *loki) Errorf(format string, args ...interface{}) {
	l.client.Errorf(format, args...)
}

func (l *loki) Close() error {
	l.client.Shutdown()
	return nil
}

func (l *loki) HttpErrorHandler(err error, c echo.Context) {
	httpError, ok := err.(*echo.HTTPError)
	if !ok {
		l.Errorf(`msg="unexpected Error in parsing error response"`)
		_ = c.JSON(http.StatusInternalServerError, nil)
	}

	resp := &payload.Response{
		Status:  false,
		Message: httpError.Message.(string),
		Error:   httpError.Message.(string),
	}

	l.Errorf(resp.Message)

	_ = c.JSON(httpError.Code, &resp)
}

func (l *loki) HttpAccessMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {

		var (
			unexpectedError     error
			start               = time.Now()
			userId              string
			JsonBodyRequst      JsonBody
			jsonFormDataRequest JsonBody
		)

		if c.Request().URL.Path != "/metrics" {

			if c.Request().Header.Get(echo.HeaderContentType) == echo.MIMEApplicationJSON {

				// decode json body to map
				json.NewDecoder(c.Request().Body).Decode(&JsonBodyRequst)

				// re assign the request body
				c.Request().Body = io.NopCloser(bytes.NewReader(JsonBodyRequst.Byte()))

				JsonBodyRequst = bodyToLog(JsonBodyRequst)

			} else {
				formData, err := c.MultipartForm()
				if err == nil {
					jsonFormDataRequest = formDataToLog(formData)
				}
			}
		}

		if err := next(c); err != nil {
			unexpectedError = err
			c.Error(err)
		}

		defer func() {
			if c.Request().URL.Path != "/metrics" {

				if c.Get("user") != nil {
					if jwtToken, ok := c.Get("user").(*jwt.Token); ok {
						if jwtTokenClaims, ok := jwtToken.Claims.(jwt.MapClaims); ok {
							userId = jwtTokenClaims["sub"].(string)
						}
					}
				}

				logInfo := fmt.Sprintf(`ip=%s method=%s path=%s status_code=%d resp_time=%s resp_size=%d user_id=%s %s body="%s" form="%s"`,
					c.RealIP(),
					c.Request().Method,
					c.Request().URL.RequestURI(),
					c.Response().Status,
					time.Since(start),
					c.Response().Size,
					userId,
					headerToLog(c.Request().Header),
					JsonBodyRequst.EscapeString(),
					jsonFormDataRequest.EscapeString(),
				)

				if unexpectedError == nil {
					l.Infof(logInfo)
				} else {
					l.Errorf(fmt.Sprintf("%s msg=\"%v\"", logInfo, unexpectedError))
				}
			}
		}()

		return nil
	}
}

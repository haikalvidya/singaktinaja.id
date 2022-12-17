package middleware

import (
	"os"

	"singkatinaja/pkg/common"

	"github.com/labstack/echo/v4"
	log "github.com/sirupsen/logrus"
)

type Logger struct {
	LogPath *string
	Level   log.Level
}

func NewLogger(LogPath *string, level log.Level) *Logger {
	return &Logger{
		LogPath: LogPath,
		Level:   level,
	}
}
func (l *Logger) LogEntry(c echo.Context) *log.Entry {

	// set log formatter
	log.SetFormatter(&log.TextFormatter{
		TimestampFormat: "2006-01-02 15:04:05",
		ForceColors:     true,
		FullTimestamp:   true,
		ForceQuote:      true,
	})

	// set log level
	log.SetLevel(l.Level)

	if l.LogPath != nil {
		f, err := os.OpenFile(*l.LogPath, os.O_WRONLY|os.O_APPEND|os.O_CREATE, 0666)
		if err != nil {
			log.Panic(err)
		}

		// set output to file and make log to json
		log.SetOutput(f)
		log.SetFormatter(&log.JSONFormatter{})
	}

	if c == nil {
		return log.WithFields(log.Fields{})
	}

	return log.WithFields(log.Fields{
		"method": c.Request().Method,
		"uri":    c.Request().URL.String(),
		"ip":     c.Request().RemoteAddr,
		"body":   c.Request().Body,
		"form":   c.Request().Form,
	})
}

func (l *Logger) LogMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		l.LogEntry(c).Info("Incoming request")
		return next(c)
	}
}

func (l *Logger) LogError(err error, c echo.Context) {

	report := err.(*echo.HTTPError)

	resp := &common.Response{
		Message: report.Message.(string),
		Error:   report.Message.(string),
	}

	l.LogEntry(c).Error(report.Message)
	_ = c.JSON(report.Code, &resp)
}

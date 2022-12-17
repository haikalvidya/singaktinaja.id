package logger

import (
	"github.com/labstack/echo/v4"
)

type Logger interface {
	Debugf(format string, args ...interface{})
	Infof(format string, args ...interface{})
	Warnf(format string, args ...interface{})
	Errorf(format string, args ...interface{})
	Close() error

	// http
	HttpErrorHandler(err error, c echo.Context)
	HttpAccessMiddleware(next echo.HandlerFunc) echo.HandlerFunc
}

type LogLevel int

const (
	DriverLoki = "loki"
)

const (
	DEBUG   LogLevel = iota
	INFO    LogLevel = iota
	WARN    LogLevel = iota
	ERROR   LogLevel = iota
	DISABLE LogLevel = iota
)

func NewLogger(driverName string, opt ...FnOpt) (Logger, error) {
	switch driverName {
	case DriverLoki:
		client, err := newLoki(opt...)
		if err != nil {
			return nil, err
		}
		return client, nil
	}

	return nil, nil
}

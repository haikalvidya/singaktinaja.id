package app

import (
	"log"
	"singkatinaja/pkg/migration"

	"singkatinaja/config"

	"github.com/go-redis/redis"
	"gorm.io/gorm"
)

type base struct {
	db     *gorm.DB
	redis  *redis.Client
	config *config.Config
	Args   []string
	SubCmd string
}

func defaultBase(o *Option) base {
	return base{
		Args:   o.Args,
		SubCmd: o.SubCmd,
	}
}

func (a *base) initConfig() (err error) {
	a.config, err = config.Load("config", ".", "./config")
	if err != nil {
		return
	}

	a.db, err = InitDB(a.config)
	if err != nil {
		return
	}

	a.redis, err = InitRedis(a.config)
	if err != nil {
		return
	}

	return
}

func (a *base) closeConfig() {

	if db, err := a.db.DB(); err == nil {
		db.Close()
	}

	log.Println("Close config")
}

type Application interface {
	Init() (err error)
	Run() (err error)
	Close() (err error)
}

const (
	TypeHTTPServer = "http"
	TypeMigration  = "migration"
)

func Run(appType string, opts ...FnOption) (err error) {
	application := New(appType, opts...)
	if err = application.Init(); err != nil {
		return
	}
	defer application.Close()

	err = application.Run()
	return
}

func New(typeApp string, fnOpts ...FnOption) Application {
	o := new(Option)
	for _, fnOpt := range fnOpts {
		fnOpt(o)
	}
	o.Default()

	defaultBase := defaultBase(o)
	switch typeApp {
	case TypeMigration:
		return &migrationApp{
			base:    defaultBase,
			Options: o.MigrationOptions,
		}
	default:
		return &httpApp{
			base: defaultBase,
		}
	}
}

type Option struct {
	Args             []string
	SubCmd           string
	MigrationOptions []migration.FnOpt
}

func (o *Option) Default() *Option { return o }

type FnOption func(o *Option)

func WithArgs(args []string) FnOption {
	return func(o *Option) {
		o.Args = args
	}
}

func WithSubCmd(subCmd string) FnOption {
	return func(o *Option) {
		o.SubCmd = subCmd
	}
}

func WithMigrationOption(opts ...migration.FnOpt) FnOption {
	return func(o *Option) {
		o.MigrationOptions = opts
	}
}

package app

import (
	"fmt"
	"time"

	"singkatinaja/config"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func InitDB(cfg *config.Config) (*gorm.DB, error) {
	dsn := fmt.Sprintf(`%s:%s@tcp(%s:%s)/%s?%s`,
		cfg.Database.User, cfg.Database.Password, cfg.Database.Host, cfg.Database.Port, cfg.Database.Name, cfg.Database.Params)

	var logMode logger.LogLevel

	if cfg.Server.Env == config.DEV {
		logMode = logger.Info
	} else if cfg.Server.Env == config.PRODUCTION {
		logMode = logger.Error
	}

	gormConfig := &gorm.Config{
		Logger: logger.Default.LogMode(logMode),
	}

	db, err := gorm.Open(mysql.Open(dsn), gormConfig)
	if err != nil {
		return nil, err
	}

	dbConfig, _ := db.DB()
	dbConfig.SetMaxIdleConns(10)
	dbConfig.SetMaxOpenConns(50)
	dbConfig.SetConnMaxIdleTime(time.Minute * 3)

	return db, err
}

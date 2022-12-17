package app

import (
	"fmt"

	"singkatinaja/pkg/migration"

	"github.com/amacneil/dbmate/pkg/dbmate"
)

type migrationApp struct {
	base
	Options []migration.FnOpt
	DBMate  *dbmate.DB
}

func (a *migrationApp) Init() (err error) {
	err = a.initConfig()
	if err != nil {
		return
	}

	urlString := fmt.Sprintf(
		"%s://%s:%s@%s:%s/%s",
		"mysql",
		a.config.Database.User,
		a.config.Database.Password,
		a.config.Database.Host,
		a.config.Database.Port,
		a.config.Database.Name,
	)

	configMigrations := []migration.FnOpt{
		migration.WithURL(urlString),
		migration.WithMigrationsTableName(a.config.Database.MigrationTableName),
	}

	a.DBMate, _ = migration.New(configMigrations...)
	return
}

func (a *migrationApp) Run() (err error) {
	switch a.SubCmd {
	case "new":
		err = a.runNew(a.Args[0])
	case "up":
		err = a.runUp()
	case "down":
		err = a.runDown()
	}
	return
}

func (a *migrationApp) Close() (err error) {
	a.closeConfig()
	return
}

func (a *migrationApp) runUp() (err error) {
	err = a.DBMate.CreateAndMigrate()
	return
}

func (a *migrationApp) runNew(args string) (err error) {
	err = a.DBMate.NewMigration(args)
	return
}

func (a *migrationApp) runDown() (err error) {
	err = a.DBMate.Rollback()
	return
}

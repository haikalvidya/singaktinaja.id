package cmd

import (
	"singkatinaja/internal/app"

	"github.com/spf13/cobra"
)

var (
	migrationCmd = &cobra.Command{
		Use:   "migrate",
		Short: "List any migration comands in this application.",
	}
	migrationUpCmd = &cobra.Command{
		Use:   "up",
		Short: "Up the migrations config",
		RunE: func(cmd *cobra.Command, args []string) (err error) {
			err = runMigration("up", args)
			return
		},
	}
	migrationNewCmd = &cobra.Command{
		Use:   "new",
		Short: "New migration file",
		RunE: func(cmd *cobra.Command, args []string) (err error) {
			err = runMigration("new", args)
			return
		},
	}
	migrationDownCmd = &cobra.Command{
		Use:   "down",
		Short: "Down the migrations config",
		RunE: func(cmd *cobra.Command, args []string) (err error) {
			err = runMigration("down", args)
			return
		},
	}
)

func runMigration(subCmd string, args []string) (err error) {

	err = app.Run(
		app.TypeMigration,
		app.WithArgs(args),
		app.WithSubCmd(subCmd),
	)

	return
}

func init() {
	rootCmd.AddCommand(migrationCmd)
	migrationCmd.AddCommand(migrationUpCmd)
	migrationCmd.AddCommand(migrationNewCmd)
	migrationCmd.AddCommand(migrationDownCmd)
}

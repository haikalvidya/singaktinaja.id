package config

import "github.com/spf13/viper"

const (
	DEV        = "dev"
	PRODUCTION = "production"
)

type Config struct {
	Server   ServerConfig   `mapstructure:"server"`
	Database DatabaseConfig `mapstructure:"database"`
	Mail     MailConfig     `mapstructure:"mail"`
	JWT      JWTConfig      `mapstructure:"jwt"`
}

type ServerConfig struct {
	Address string `mapstructure:"address"`
	Env     string `mapstructure:"env"`
}

type DatabaseConfig struct {
	Host               string `mapstructure:"host"`
	Port               string `mapstructure:"port"`
	User               string `mapstructure:"user"`
	Password           string `mapstructure:"password"`
	Name               string `mapstructure:"name"`
	Params             string `mapstructure:"params"`
	MigrationTableName string `mapstructure:"migration_table_name"`
}

type MailConfig struct {
	APIKey string `mapstructure:"api_key"`
}

type JWTConfig struct {
	Secret                 string `mapstructure:"secret"`
	AccessTokenExpireHour  int    `mapstructure:"access_token_expire_hour"`
	RefreshTokenExpireHour int    `mapstructure:"refresh_token_expire_hour"`
}

func Load(cfgName string, paths ...string) (c *Config, err error) {
	viper.SetConfigName(cfgName)
	viper.SetConfigType("yaml")

	for _, path := range paths {
		viper.AddConfigPath(path)
	}

	err = viper.ReadInConfig()
	if err != nil {
		return
	}

	err = viper.Unmarshal(&c)
	return
}

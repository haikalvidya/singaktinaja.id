package logger

type LokiConfig struct {
	Url    string
	Source string
	Env    string
}

type Options struct {
	LokiConfig *LokiConfig
	SendLevel  LogLevel
	PrintLevel LogLevel
}

func (o *Options) Default() {
	o.SendLevel = INFO
	o.PrintLevel = ERROR
}

type FnOpt func(o *Options) (err error)

func WithLokiConfig(cfg *LokiConfig) FnOpt {
	return func(o *Options) (err error) {
		o.LokiConfig = cfg
		return
	}
}

func WithSendLevel(lvl LogLevel) FnOpt {
	return func(o *Options) (err error) {
		o.SendLevel = lvl
		return
	}
}

func WithPrintLevel(lvl LogLevel) FnOpt {
	return func(o *Options) (err error) {
		o.PrintLevel = lvl
		return
	}
}

func DisableStdOut() FnOpt {
	return func(o *Options) (err error) {
		o.PrintLevel = DISABLE
		return
	}
}

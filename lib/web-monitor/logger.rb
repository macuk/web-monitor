module WebMonitor
  class Logger
    require 'logger'

    def initialize(config)
      @log = ::Logger.new(config['log_file'])
      @log.datetime_format = "%Y-%m-%d %H:%M:%S"
      @log.formatter = proc do |severity, datetime, progname, msg|
        "#{datetime} #{severity} #{msg}\n"
      end
    end

    def info(msg)
      @log.info(msg)
    end

    def error(msg)
      @log.error(msg)
    end

    def fatal(msg)
      @log.fatal(msg)
    end

    def close
      @log.close
    end
  end
end

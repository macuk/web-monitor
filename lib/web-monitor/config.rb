module WebMonitor
  class Config
    require 'yaml'
    require 'ostruct'

    DEFAULTS = {
      response_time_limit: 3.0,
      alert_mail: nil,
      urls_file: 'urls.csv',
      log_file: 'web-monitor.log',
      delay: 1.0,
    }

    def initialize(config_file)
      struct = YAML::load(File.open(config_file))
      @config = OpenStruct.new(struct)
    end

    def method_missing(method, *args, &block)
      out = @config.send(method)
      if out.nil?
        return DEFAULTS[method]
      else
        case method
        when :response_time_limit
          out.to_f
        when :delay
          out.to_f
        else
          out
        end
      end
    end
  end
end

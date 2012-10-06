module WebMonitor
  class Monitor
    require 'yaml'
    require 'csv'

    def initialize(config_file)
      @config = YAML::load(File.open(config_file))
      @logger = Logger.new(@config)
      @mailer = Mailer.new(@config)
      @requester = Requester.new(@config)
    end

    def process
      CSV.foreach(@config['urls_file']) do |name, url|
        begin
          @requester.check(url)
        rescue Exception => e
          @logger.fatal("#{name} (#{url}): #{e.class} #{e.message}")
          @mailer.send("#{name} #{e.class}")
          next
        end
        v = ResponseValidator.new(@requester.time, @requester.status, @config)
        if v.valid?
          @logger.info("#{name} (#{url}): %.1fs" % @requester.time)
        else
          @logger.error("#{name} (#{url}): #{v.error_msg}")
          @mailer.send("#{name} #{v.error_msg}")
        end
        sleep @config['delay'].to_i
      end
    end
  end
end

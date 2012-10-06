module WebMonitor
  class Mailer
    def initialize(config)
      @email = config['alert_mail']
    end

    def send(msg)
      system %(echo '' | mail -s "#{msg}" #{@email})
    end
  end
end

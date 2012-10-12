module WebMonitor
  # Validate response time and status
  class ResponseValidator
    attr_accessor :time, :status

    def initialize(time, status, config)
      @time, @status = time.to_f, status.to_i
      @limit = config.response_time_limit
    end

    def valid?
      validate_status and validate_time
    end

    def error_msg
      return "Status=#{@status}" unless validate_status
      return "Time=%.1fs" % @time unless validate_time
    end

    protected
      def validate_time
        @time <= @limit
      end

      def validate_status
        @status == 200
      end
  end
end

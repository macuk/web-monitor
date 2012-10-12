module WebMonitor
  # Request URL and return time and status
  class Requester
    require 'net/http'
    require 'benchmark'
    require 'timeout'

    attr_reader :time, :status
    attr_writer :benchmark

    def initialize(config)
      @limit = config.response_time_limit
      @timeout = @limit + 1.0
      @benchmark = Benchmark
    end

    def check(url)
      Timeout::timeout(@timeout) do
        time = @benchmark.measure { get(url.strip) }
        @time = time.real.to_f
      end
    rescue Timeout::Error
      @time = @timeout
      @status = 0
    end

    protected
      def get(url)
        uri = URI.parse(url)
        Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new uri.request_uri
          response = http.request request
          @status = response.code.to_i
        end
      end
  end
end

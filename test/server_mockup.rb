require 'soap/rpc/standaloneServer'
require 'socket'
require 'timeout'

class ServerMockup < ::SOAP::RPC::StandaloneServer
  require 'test/server_mockup/nfe_status_servico2_mockup'
  CLASSES = [ServerMockup::NfeStatusServico2Mockup]

  def initialize(*arg)
    super(*arg)

    CLASSES.each do |klass|
      servant = klass.new
      klass::Methods.each do |definitions|
        add_document_method(servant, *definitions)
      end
    end
  end

  def uri
    "http://#{@host}:#{@port}/"
  end

  class << self
    def start(port = 10080)
      self.stop
      @mockup_server = ServerMockup.new('app', nil, '127.0.0.1', port)
      Thread.new do
        trap(:INT) do
          server.shutdown
        end
        @mockup_server.start
      end
      RNFe.wsdl_endpoint = @mockup_server.uri
      @mockup_server
    end

    def stop(port = 10080)
      @mockup_server ||= nil
      if @mockup_server
        @mockup_server.shutdown
        while port_open?("127.0.0.1", port)
          sleep 0.1
        end
        @mockup_server = nil
        return true
      end
      return false
    end

    def last_request_time
      @last_request_time ||= nil
    end

    def last_request_time=(last_request)
      @last_request_time = last_request
    end

    private
    def port_open?(ip, port)
      begin
        Timeout::timeout(1) do
          s = TCPSocket.new(ip, port)
          s.close
          return true
        end
      rescue Timeout::Error, Errno::ECONNREFUSED, Errno::EHOSTUNREACH; end
      return false
    end
  end
end

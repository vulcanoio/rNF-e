require "lib/rnfe/version"
require "lib/rnfe/nfe_status_servico2"

module RNFe
  class << self
    def wsdl_endpoint
      @sdl_endpoint ||= nil
    end

    def wsdl_endpoint=(endpoint)
      @sdl_endpoint = endpoint.to_s
    end
  end
end

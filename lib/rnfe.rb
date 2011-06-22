require "lib/rnfe/nfe_status_servico2"

module RNFe
  class << self
    # Get the custom endpoint. Returns nil if none was set
    def wsdl_endpoint
      @sdl_endpoint ||= nil
    end

    # Sets a endpoint to be used for the next requests instead of the one
    # specified in the WSDL. Pass nil to use the default.
    def wsdl_endpoint=(endpoint)
      @sdl_endpoint = endpoint.to_s
    end
  end
end

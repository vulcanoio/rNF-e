require 'nokogiri'

class NfeStatusServico2
  NAMESPACE = "http://www.portalfiscal.inf.br/nfe"
  REQUEST_SCHEMA = "schemas/consStatServ_v2.00.xsd"
  RESPONSE_SCHEMA = "schemas/retConsStatServ_v2.00.xsd"
  WSDL = "wsdls/nfeStatusServico2.wsdl"

  class << self
    # Check the NFe service status. Returns a hash with information about the
    # service.
    def service_status
      request_message_body = create_message_body('43', true)
      service_response = communicate(request_message_body)
      service_response = service_response[:nfe_status_servico_nf2][:ret_cons_stat_serv]
    end

    private
    def create_message_body(uf_code, homologation = false)
      document = Nokogiri::XML::Document.new('')
      document.root = root = Nokogiri::XML::Node.new('consStatServ', document)
      root['xmlns'] = NAMESPACE
      root['versao'] = '2.00'

      root.add_child(tp_amb = Nokogiri::XML::Node.new('tpAmb', root))
      tp_amb.content = '2'

      root.add_child(c_uf = Nokogiri::XML::Node.new('cUF', root))
      c_uf.content = uf_code

      root.add_child(x_serv = Nokogiri::XML::Node.new('xServ', root))
      x_serv.content = 'STATUS'

      request_body = document.root.to_s

      validate_request_body(request_body)
    end

    def validate_request_body(request_body)
      validate_with_schema(request_body, REQUEST_SCHEMA)
    end

    def validate_response_body(response_document)
      response_body = extract_response(response_document)
      validate_with_schema(response_body, RESPONSE_SCHEMA)
    end

    def validate_with_schema(document, schema_file_path)
      xsd = Nokogiri::XML::Schema(File.open(schema_file_path))
      errors = xsd.validate(document)
      !errors.empty? ? raise(errors.join(", ")) : true
    end

    def extract_response(response_document)
      Nokogiri.XML(response_document.to_xml).xpath('//env:Body/nfeStatusServicoNF2').first
    end

    def communicate(request_message_body)
      require 'savon'

      client = Savon::Client.new do
        wsdl.endpoint = RNFe.wsdl_endpoint if RNFe.wsdl_endpoint
        wsdl.document = File.expand_path WSDL
      end

      response_document = client.request :nfe_status_servico_nf2 do soap.body = request_message_body end

      validate_response_body(response_document)

      return response_document.to_hash
    end
  end
end

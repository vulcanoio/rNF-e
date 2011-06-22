#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "rexml/document"

class ServerMockup
  class NfeStatusServico2Mockup
    Namespace = 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico2'

    Methods = [
               ['http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico2/nfeStatusServicoNF2',
                'nfeStatusServicoNF2',
                XSD::QName.new(Namespace, 'nfeStatusServicoNF2'),
                XSD::QName.new(Namespace, 'nfeStatusServicoNF2')]
              ]

    def initialize
      @status_code = "107"
      @motive = "Serviço em Operação"
    end

    def nfeStatusServicoNF2(nfeDadosMsg)
      time = Time.now
      time = time.strftime("%Y-%m-%dT%H:%M:%S")
      ServerMockup.last_request_time = time
      string = <<EOF
<nfeStatusServicoNF2>
<retConsStatServ xmlns="http://www.portalfiscal.inf.br/nfe" versao="2.00">
  <tpAmb>2</tpAmb>
  <verAplic>RS-0.0.1</verAplic>
  <cStat>#{@status_code}</cStat>
  <xMotivo>#{@motive}</xMotivo>
  <cUF>43</cUF>
  <dhRecbto>#{time}</dhRecbto>
</retConsStatServ>
</nfeStatusServicoNF2>
EOF
      REXML::Document.new string
    end

    def set_service_status(status)
      case status
      when :running
        @status_code = "107"
        @motive = "Serviço em Operação"
      when :temporary_maintenance
        @status_code = "108"
        @motive = "Serviço Paralisado Temporariamente"
      when :unscheduled_maintenance
        @status_code = "109"
        @motive = "Serviço Paralisado sem Previsão"
      else
        raise "Unknown status '#{status.inspect}'"
      end
    end
  end
end

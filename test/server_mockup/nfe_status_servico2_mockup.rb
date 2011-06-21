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

    def nfeStatusServicoNF2(nfeDadosMsg)
      time = Time.now
      time = time.strftime("%Y-%m-%dT%H:%M:%S")
      ServerMockup.last_request_time = time
      string = <<EOF
<nfeStatusServicoNF2>
<retConsStatServ xmlns="http://www.portalfiscal.inf.br/nfe" versao="2.00">
  <tpAmb>2</tpAmb>
  <verAplic>RS-0.0.1</verAplic>
  <cStat>107</cStat>
  <xMotivo>Serviço em Operação</xMotivo>
  <cUF>43</cUF>
  <dhRecbto>#{time}</dhRecbto>
</retConsStatServ>
</nfeStatusServicoNF2>
EOF
      REXML::Document.new string
    end
  end
end

# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class NfeStatusServico2Test < Test::Unit::TestCase
  def setup
    start_mockup_server
  end

  def test_get_status
    received_status = NfeStatusServico2.service_status
    assert_equal({:c_stat => "107",
                   :c_uf => "43",
                   :@versao => "2.00",
                   :dh_recbto => DateTime.parse(ServerMockup.last_request_time),
                   :@xmlns => "http://www.portalfiscal.inf.br/nfe",
                   :ver_aplic => "RS-0.0.1",
                   :x_motivo => "Serviço em Operação",
                   :tp_amb => "2"}, received_status)
  end
end

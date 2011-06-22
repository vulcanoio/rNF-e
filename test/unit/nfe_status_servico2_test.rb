# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class NfeStatusServico2Test < Test::Unit::TestCase
  def setup
    ServerMockup.start
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

  def test_get_status_with_mean_response_time
    ServerMockup.set_service_status(:running, {:t_med => 15})
    received_status = NfeStatusServico2.service_status
    assert_equal({:c_stat => "107",
                   :c_uf => "43",
                   :@versao => "2.00",
                   :dh_recbto => DateTime.parse(ServerMockup.last_request_time),
                   :@xmlns => "http://www.portalfiscal.inf.br/nfe",
                   :ver_aplic => "RS-0.0.1",
                   :x_motivo => "Serviço em Operação",
                   :tp_amb => "2",
                   :t_med => "15"}, received_status)
  end

  def test_get_status_with_service_in_temporary_maintenance
    ServerMockup.set_service_status :temporary_maintenance
    received_status = NfeStatusServico2.service_status
    assert_equal({:c_stat => "108",
                   :c_uf => "43",
                   :@versao => "2.00",
                   :dh_recbto => DateTime.parse(ServerMockup.last_request_time),
                   :@xmlns => "http://www.portalfiscal.inf.br/nfe",
                   :ver_aplic => "RS-0.0.1",
                   :x_motivo => "Serviço Paralisado Temporariamente",
                   :tp_amb => "2"}, received_status)
  end

  def test_get_status_with_service_in_temporary_maintenance_with_return_time
    return_time = Time.now + 86400 # exactly one day from now
    ServerMockup.set_service_status(:temporary_maintenance, {:dh_retorno => return_time})
    received_status = NfeStatusServico2.service_status
    assert_equal({:c_stat => "108",
                   :c_uf => "43",
                   :@versao => "2.00",
                   :dh_recbto => DateTime.parse(ServerMockup.last_request_time),
                   :@xmlns => "http://www.portalfiscal.inf.br/nfe",
                   :ver_aplic => "RS-0.0.1",
                   :x_motivo => "Serviço Paralisado Temporariamente",
                   :tp_amb => "2",
                   :dh_retorno => DateTime.parse(return_time.strftime("%Y-%m-%dT%H:%M:%S"))}, received_status)
  end

  def test_get_status_with_service_in_temporary_maintenance_with_observation
    ServerMockup.set_service_status(:temporary_maintenance, {:x_obs => "Atualização dos servidores"})
    received_status = NfeStatusServico2.service_status
    assert_equal({:c_stat => "108",
                   :c_uf => "43",
                   :@versao => "2.00",
                   :dh_recbto => DateTime.parse(ServerMockup.last_request_time),
                   :@xmlns => "http://www.portalfiscal.inf.br/nfe",
                   :ver_aplic => "RS-0.0.1",
                   :x_motivo => "Serviço Paralisado Temporariamente",
                   :tp_amb => "2",
                   :x_obs => "Atualização dos servidores"}, received_status)
  end

  def test_get_status_with_service_in_unscheduled_maintenance
    ServerMockup.set_service_status :unscheduled_maintenance
    received_status = NfeStatusServico2.service_status
    assert_equal({:c_stat => "109",
                   :c_uf => "43",
                   :@versao => "2.00",
                   :dh_recbto => DateTime.parse(ServerMockup.last_request_time),
                   :@xmlns => "http://www.portalfiscal.inf.br/nfe",
                   :ver_aplic => "RS-0.0.1",
                   :x_motivo => "Serviço Paralisado sem Previsão",
                   :tp_amb => "2"}, received_status)
  end
end

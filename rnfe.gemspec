# -*- coding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rnfe/version"

Gem::Specification.new do |gem|
  gem.name        = "rnfe"
  gem.version     = RNFe::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["O.S. Systems Softwares Ltda."]
  gem.email       = "contato@ossystems.com.br"
  gem.homepage    = "http://www.ossystems.com.br/"
  gem.summary     = "API em Ruby para integração com o Projeto Nota Fiscal Eletrônica"
  gem.description = "Use esta gem para auxiliar a integração de projetos que emitem notas fiscais eletrônicas aos Portais das Secretarias das Fazendas dos Estados"

  gem.files         = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*"]
  gem.test_files    = Dir['{test}/**/*']
  gem.require_paths = ["lib"]

  gem.add_dependency 'savon', '>= 0.9.2'
end

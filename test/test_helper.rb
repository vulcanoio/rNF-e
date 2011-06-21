require 'test/unit'

require 'lib/rnfe'
require 'test/savon_configure'
require 'test/server_mockup'

class Test::Unit::TestCase
  def start_mockup_server(port = 10080)
    ServerMockup.start port
  end

  def stop_mockup_server
    ServerMockup.stop port
  end
end

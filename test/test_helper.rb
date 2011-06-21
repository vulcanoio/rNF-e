require 'rubygems'

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

Bundler.require(:default, :test)

require 'test/unit'

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

require 'savon'

# disable logging to the console:
Savon.configure{|config| config.log = false}
HTTPI.log = false

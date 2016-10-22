lib = File.expand_path('../../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

class ApplicationController < ActionController::Base
  protect_from_forgery
end

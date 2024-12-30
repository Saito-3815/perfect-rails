require "rack"
require_relative "app"
require_relative "simple_middleware"

use Rack::Runtime
use SimpleMiddleware
run App.new

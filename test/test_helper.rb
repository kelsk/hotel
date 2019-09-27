# Add simplecov
require "simplecov"
SimpleCov.start


require "minitest"
require "minitest/autorun"
require "minitest/reporters"

require 'date'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!

require_relative '../lib/reservation'
require_relative '../lib/room'
require_relative '../lib/reservation_manager'
require_relative '../lib/calendar'
require_relative '../lib/block'
require_relative '../lib/reservation_creator'
# frozen_string_literal: true

require 'zeitwerk'
require 'active_support/core_ext/integer/time'

class Boot
  AUTOLOAD_DIRS = [
    File.absolute_path("#{__dir__}/../lib")
  ].freeze

  def self.call
    new.call
  end

  def call
    load_zeitwerk
  end

  private

  def load_zeitwerk
    loader = Zeitwerk::Loader.new
    AUTOLOAD_DIRS.each { |dir| loader.push_dir(dir) }
    loader.enable_reloading if development?
    loader.setup
    loader.eager_load
  end

  def development?
    ENV['RACK_ENV'] == 'development'
  end
end

Boot.call

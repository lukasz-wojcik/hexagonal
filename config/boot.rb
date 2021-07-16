require 'zeitwerk'

class Boot
  AUTOLOAD_DIRS = [
    File.absolute_path("#{__dir__}/../lib")
  ]

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

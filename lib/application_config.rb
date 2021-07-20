require 'dry-container'

class ApplicationConfig
  extend Dry::Container::Mixin
  OBTAINING_RATES_PREFIX = 'obtaining_rates_'

  def self.register_obtaining_rates_repository(key: 'default', repository:)
    register("#{OBTAINING_RATES_PREFIX}#{key}", repository)
  end

  def self.obtaining_rates_repository(key: 'default')
    resolve("#{OBTAINING_RATES_PREFIX}#{key}",)
  end
end

rates_file_db_path = File.expand_path(File.join(Dir.pwd, 'config/rates.yml'))
ApplicationConfig.register_obtaining_rates_repository(repository: Repositories::FileDbRates.new(rates_file_db_path))
ApplicationConfig.register_obtaining_rates_repository(key: 'in_memory', repository: Repositories::InMemoryRates.new)


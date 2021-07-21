require 'dry-container'

class ApplicationConfig
  extend Dry::Container::Mixin
  OBTAINING_RATES_PREFIX = 'obtaining_rates_'
  PERMITS_REPOSITORY_PREFIX = 'permits_repository_'
  PAYMENT_SERVICE_PREFIX = 'payment_service_'

  def self.register_obtaining_rates_repository(key: 'default', repository:)
    register("#{OBTAINING_RATES_PREFIX}#{key}", repository)
  end

  def self.obtaining_rates_repository(key: 'default')
    resolve("#{OBTAINING_RATES_PREFIX}#{key}",)
  end

  def self.register_permits_repository(key: 'default', repository:)
    register("#{PERMITS_REPOSITORY_PREFIX}#{key}", repository)
  end

  def self.permits_repository(key: 'default')
    resolve("#{PERMITS_REPOSITORY_PREFIX}#{key}")
  end

  def self.register_payment_service(key: 'default', service:)
    register("#{PAYMENT_SERVICE_PREFIX}#{key}", service)
  end

  def self.payment_service(key: 'default')
    resolve("#{PAYMENT_SERVICE_PREFIX}#{key}")
  end
end

rates_file_db_path = File.expand_path(File.join(Dir.pwd, 'config/rates.yml'))
ApplicationConfig.register_obtaining_rates_repository(repository: Repositories::FileDbRates.new(rates_file_db_path))
ApplicationConfig.register_obtaining_rates_repository(key: 'in_memory', repository: Repositories::InMemoryRates.new)

ApplicationConfig.register_permits_repository(key: 'in_memory', repository: Repositories::InMemoryPermits.new)
ApplicationConfig.register_payment_service(key: 'fake', service: Adapters::FakePaymentService.new)

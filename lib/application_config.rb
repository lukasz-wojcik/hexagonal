# frozen_string_literal: true

require 'dry-container'

class ApplicationConfig
  extend Dry::Container::Mixin
  RATES_PREFIX = 'rates_repository_'
  PERMITS_REPOSITORY_PREFIX = 'permits_repository_'
  PAYMENT_SERVICE_PREFIX = 'payment_service_'

  def self.register_rates_repository(repository:, key:)
    register("#{RATES_PREFIX}#{key}", repository)
  end

  def self.rates_repository(key:)
    resolve("#{RATES_PREFIX}#{key}")
  end

  def self.register_permits_repository(repository:, key:)
    register("#{PERMITS_REPOSITORY_PREFIX}#{key}", repository)
  end

  def self.permits_repository(key:)
    resolve("#{PERMITS_REPOSITORY_PREFIX}#{key}")
  end

  def self.register_payment_service(service:, key:)
    register("#{PAYMENT_SERVICE_PREFIX}#{key}", service)
  end

  def self.payment_service(key:)
    resolve("#{PAYMENT_SERVICE_PREFIX}#{key}")
  end
end

ApplicationConfig.register_rates_repository(
  key: 'file_db',
  repository: ParkingCars::Adapters::Repositories::FileDbRates.new(
    File.expand_path(File.join(Dir.pwd, 'config/rates.yml')))
)
ApplicationConfig.register_rates_repository(
  key: 'in_memory',
  repository: ParkingCars::Adapters::Repositories::InMemoryRates.new
)

ApplicationConfig.register_permits_repository(
  key: 'in_memory',
  repository: ParkingCars::Adapters::Repositories::InMemoryPermits.new
)
ApplicationConfig.register_permits_repository(
  key: 'mysql_db',
  repository: ParkingCars::Adapters::Repositories::InMemoryPermits.new
)

ApplicationConfig.register_payment_service(
  key: 'fake',
  service: ParkingCars::Adapters::Payments::FakePaymentService.new
)

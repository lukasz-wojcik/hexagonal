# frozen_string_literal: true

require 'dry-container'
require 'yaml'

module ParkingCars
  class Configuration
    extend Dry::Container::Mixin

    NAMESPACE = 'parking_cars'
    ADAPTERS_CONFIG = YAML.load_file(File.expand_path(File.join(Dir.pwd, 'config/adapters.yml')))
    RACK_ENV = ENV.fetch('RACK_ENV', 'development')
    RATES_PREFIX = 'rates_repository_'
    PERMITS_PREFIX = 'permits_repository_'
    PAYMENT_SERVICE_PREFIX = 'payment_service_'

    class << self
      def register_adapters
        register_rates_repositories
        register_permits_repositories
      end

      def register_facades
        register('rates_facade', initialize_rates_facade)
        register('permits_facade', initialize_permits_facade)
      end

      # adapter is needed to be able to explicitly fetch desired registered class
      def rates_repository(adapter: nil)
        resolve(registered_dependency_key(RATES_PREFIX, 'rates_repository', adapter: adapter))
      end

      def permits_repository(adapter: nil)
        resolve(registered_dependency_key(PERMITS_PREFIX, 'permits_repository', adapter: adapter))
      end

      def payment_service(key:)
        resolve("#{PAYMENT_SERVICE_PREFIX}#{key}")
      end

      def rates_facade
        resolve('rates_facade')
      end

      def permits_facade
        resolve('permits_facade')
      end

      def payments_facade
        ParkingCars::Adapters::Payments::FakePaymentService.new
      end

      private

      def register_rates_repositories
        register("#{RATES_PREFIX}in_memory", ParkingCars::Adapters::Repositories::InMemoryRates.new)
        register(
          "#{RATES_PREFIX}file_db",
          ParkingCars::Adapters::Repositories::FileDbRates.new(
            File.expand_path(File.join(Dir.pwd, 'config/rates.yml'))
          )
        )
      end

      def register_permits_repositories
        register("#{PERMITS_PREFIX}in_memory", ParkingCars::Adapters::Repositories::InMemoryPermits.new)
        register("#{PERMITS_PREFIX}mongo_db", ParkingCars::Adapters::Repositories::MongoDbPermits.new)
      end

      def register_payment_service(service:, key:)
        register("#{PAYMENT_SERVICE_PREFIX}#{key}", service)
      end

      def registered_dependency_key(prefix, dependency_name, adapter: nil)
        [prefix, adapter || ADAPTERS_CONFIG.dig(RACK_ENV, NAMESPACE, dependency_name)].join
      end

      def initialize_rates_facade
        ParkingCars::RatesFacade.new(rates_repository: rates_repository)
      end

      def initialize_permits_facade
        ParkingCars::PermitsFacade.new(
          repository: permits_repository,
          rates_facade: rates_facade,
          payments_facade: payments_facade
        )
      end
    end
  end
end
ParkingCars::Configuration.register_adapters
ParkingCars::Configuration.register_facades

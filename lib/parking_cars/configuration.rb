# frozen_string_literal: true

require 'dry-container'
require 'yaml'

module ParkingCars
  class Configuration
    extend Dry::Container::Mixin

    NAMESPACE = 'parking_cars'
    ADAPTERS_CONFIG = YAML.load_file(File.expand_path(File.join(Dir.pwd, 'config/adapters.yml')))
    RACK_ENV = ENV.fetch('RACK_ENV', 'development')

    class << self
      def register_facades
        register('rates_facade', initialize_rates_facade)
        register('permits_facade', initialize_permits_facade)
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

      def rates_repository
        ApplicationConfig.rates_repository(key: ADAPTERS_CONFIG.dig(RACK_ENV, NAMESPACE, 'rates_repository'))
      end

      def permits_repository
        ApplicationConfig.permits_repository(key: ADAPTERS_CONFIG.dig(RACK_ENV, NAMESPACE, 'permits_repository'))
      end

      private

      def initialize_rates_facade
        ParkingCars::RatesFacade.new(rates_repository: rates_repository)
      end

      def initialize_permits_facade
        ParkingCars::PermitsFacade.new(
          repository: ApplicationConfig.permits_repository(
            key: ADAPTERS_CONFIG.fetch(RACK_ENV).fetch(NAMESPACE).fetch('permits_repository')
          ),
          rates_facade: rates_facade,
          payments_facade: ::ParkingCars::Configuration.payments_facade
        )
      end
    end
  end
end

ParkingCars::Configuration.register_facades

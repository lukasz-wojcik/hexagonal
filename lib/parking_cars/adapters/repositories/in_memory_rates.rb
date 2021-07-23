# frozen_string_literal: true

module ParkingCars
  module Adapters
    module Repositories
      class InMemoryRates
        def initialize(rates: [])
          self.rates = rates
        end

        def add_rate(rate)
          raise 'Invalid rate' unless rate.is_a?(ParkingCars::Domain::Entities::Rate)

          rates << rate
        end

        def get_all_rates
          rates
        end

        def get_rate_by_name(rate_name)
          rate = rates.detect { |rate| rate.name == rate_name }
          raise "Rate not found: #{rate_name}" unless rate

          rate
        end

        def destroy_all
          self.rates = []
        end

        private

        attr_accessor :rates
      end
    end
  end
end

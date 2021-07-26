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

        def all_rates
          rates
        end

        def rate_by_name(rate_name)
          found_rate = rates.detect { |rate| rate.name == rate_name }
          raise "Rate not found: #{rate_name}" unless found_rate

          found_rate
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

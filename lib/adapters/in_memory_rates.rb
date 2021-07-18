module Adapters
  class InMemoryRates
    def initialize(rates: nil)
      @rates = rates || default_rates
    end

    def add_rate(rate)
      raise 'Invalid rate' unless rate.is_a?(ParkingCars::Entities::Rate)
      @rates << rate
    end

    def get_all_rates
      @rates
    end

    private

    def default_rates
      [
        ParkingCars::Entities::Rate.new(name: 'Zone 1', min_minutes_allowed: 10, max_minutes_allowed: 180, cost_per_hour: 5)
      ]
    end
  end
end

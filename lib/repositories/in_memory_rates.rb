module Repositories
  class InMemoryRates
    def initialize(rates: [])
      self.rates = rates
    end

    def add_rate(rate)
      raise 'Invalid rate' unless rate.is_a?(ParkingCars::Entities::Rate)
      rates << rate
    end

    def get_all_rates
      rates
    end

    private

    attr_accessor :rates
  end
end

# frozen_string_literal: true

require 'rspec'

describe ParkingCars::RatesFacade do
  describe 'all_rates' do
    it 'returns all rates' do
      facade = ParkingCars::Configuration.rates_facade

      populate_repository_with_rates(
        [
          ParkingCars::Domain::Entities::Rate.new(name: 'Zone 1', min_minutes_allowed: 10, max_minutes_allowed: 180,
                                                  cost_per_hour: 5),
          ParkingCars::Domain::Entities::Rate.new(name: 'Zone 2', min_minutes_allowed: 10, max_minutes_allowed: 270,
                                                  cost_per_hour: 3),
          ParkingCars::Domain::Entities::Rate.new(name: 'Zone 3', min_minutes_allowed: 10, max_minutes_allowed: 360,
                                                  cost_per_hour: 1)
        ]
      )
      rates = facade.all_rates

      expect(rates.size).to eq(3)
    end

    def populate_repository_with_rates(rates)
      repository = ParkingCars::Configuration.rates_repository
      rates.each { |rate| repository.add_rate(rate) }
    end
  end
end

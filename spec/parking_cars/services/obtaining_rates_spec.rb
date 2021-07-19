require_relative '../../spec_helper'

describe ParkingCars::Services::ObtainingRates do

  it 'returns all rate entities' do
    rate_entities = [
      ParkingCars::Entities::Rate.new(name: 'Zone 1', min_minutes_allowed: 10, max_minutes_allowed: 180, cost_per_hour: 5),
      ParkingCars::Entities::Rate.new(name: 'Zone 2', min_minutes_allowed: 10, max_minutes_allowed: 270, cost_per_hour: 3),
      ParkingCars::Entities::Rate.new(name: 'Zone 3', min_minutes_allowed: 10, max_minutes_allowed: 360, cost_per_hour: 1)
    ]
    repository = ::Repositories::InMemoryRates.new(rates: rate_entities)

    service = ParkingCars::Services::ObtainingRates.new(repository: repository)
    rates = service.get_all_rates

    expect(rates.size).to eq(3)
  end
end

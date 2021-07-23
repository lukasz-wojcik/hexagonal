# frozen_string_literal: true

require_relative '../../spec_helper'

describe ParkingCars::Services::ObtainingRates do
  it 'returns all rate entities' do
    repository = repository_with_rates(
      [
        ParkingCars::Domain::Entities::Rate.new(name: 'Zone 1', min_minutes_allowed: 10, max_minutes_allowed: 180,
                                                cost_per_hour: 5),
        ParkingCars::Domain::Entities::Rate.new(name: 'Zone 2', min_minutes_allowed: 10, max_minutes_allowed: 270,
                                                cost_per_hour: 3),
        ParkingCars::Domain::Entities::Rate.new(name: 'Zone 3', min_minutes_allowed: 10, max_minutes_allowed: 360,
                                                cost_per_hour: 1)
      ]
    )
    service = ParkingCars::Services::ObtainingRates.new(repository: repository)
    rates = service.get_all_rates

    expect(rates.size).to eq(3)
  end

  def repository_with_rates(rates)
    ApplicationConfig.obtaining_rates_repository(key: 'in_memory').tap do |repository|
      rates.each { |rate| repository.add_rate(rate) }
    end
  end
end

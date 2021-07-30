# frozen_string_literal: true

require_relative '../spec_helper'

describe ParkingCars::PermitsFacade do
  it 'issues permit' do

     populate_rates_repository_with_rates(
      [
        ParkingCars::Domain::Entities::Rate.new(name: 'Zone 1', min_minutes_allowed: 10, max_minutes_allowed: 180,
                                                cost_per_hour: 5)
      ]
    )
     facade =  ParkingCars::Configuration.permits_facade

    permit_ticket = facade.issue_permit(
      {
        plate_number: 'DES 12345',
        rate_name: 'Zone 1',
        duration: 70,
        payment_data: {
          card_number: '1234456789012345',
          cvv: '000',
          expiration_date: '06/2022'
        }
      }
    )

    expect(permit_ticket).to have_attributes(
                               code: an_instance_of(String),
                               plate_number: 'DES 12345',
                               rate_name: 'Zone 1',
                               start_date: DateTime.now,
                               end_date: DateTime.now + 70.minutes
                             )

    expect(ParkingCars::Configuration.permits_repository.find(permit_ticket.code)).to be_present
  end

  def populate_rates_repository_with_rates(rates)
    ParkingCars::Configuration.rates_repository.tap do |repository|
      rates.each { |rate| repository.add_rate(rate) }
    end
  end

end

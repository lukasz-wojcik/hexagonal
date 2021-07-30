# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'ParkingCars Issue Permit', integration: true do
  it 'issues permit' do
    permits_repository = ApplicationConfig.permits_repository(key: 'mongo_db')
    rates_facade = ParkingCars::RatesFacade.new(rates_repository: ApplicationConfig.rates_repository(key: 'file_db'))
    facade = ParkingCars::PermitsFacade.new(
      repository: permits_repository,
      rates_facade: rates_facade,
      payments_facade: ::ParkingCars::Configuration.payments_facade
    )

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

    expect(permits_repository.find(permit_ticket.code)).to be_present
  end
end

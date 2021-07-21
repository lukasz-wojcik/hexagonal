require_relative '../../spec_helper'

describe ParkingCars::Services::IssuePermit do

  it 'issues permit' do
    rates_repository = rates_repository_with_rates(
        [
          ParkingCars::Entities::Rate.new(name: 'Zone 1', min_minutes_allowed: 10, max_minutes_allowed: 180, cost_per_hour: 5),
        ]
      )
    rates_service = ParkingCars::Services::ObtainingRates.new(repository: rates_repository)

    service = ParkingCars::Services::IssuePermit.new(
      repository: ApplicationConfig.permits_repository(key: 'in_memory'),
      payment_service: ApplicationConfig.payment_service(key: 'fake'),
      rates_service: rates_service
    )

    permit_ticket = service.issue_permit(
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
  end

  def rates_repository_with_rates(rates)
    ApplicationConfig.obtaining_rates_repository(key: 'in_memory').tap do |repository|
      rates.each { |rate| repository.add_rate(rate) }
    end
  end
end

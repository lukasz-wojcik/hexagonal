require_relative '../../spec_helper'

describe ParkingCars::Services::IssuePermit do

  it 'issues permit' do
    service = ParkingCars::Services::IssuePermit.new(
      repository: ApplicationConfig.permits_repository(key: 'in_memory'),
      payment_service: ApplicationConfig.payment_service(key: 'in_memory')
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
                               end_date: DateTime.now + 70.minutes # add active support time manipulation
                             )
  end
end

require 'tempfile'
require_relative '../spec_helper'

describe Repositories::FileDbRates do
  it 'loads rates rates from file' do
    db_file = create_rates_file_db(
      [
        ['Zone 1', '10', '180', '2'],
        ['Zone 2', '10', '270', '5'],
        ['Zone 3', '10', '270', '5'],

      ]
    )
    all_rates = Repositories::FileDbRates.new(db_file.path).get_all_rates

    expect(all_rates.size).to eq(3)
    expect(all_rates).to all(be_a(ParkingCars::Entities::Rate))
  end

  def create_rates_file_db(rates)
    Tempfile.new('rates_db').tap do |file|
      csv_rates = CSV.generate do |csv|
        rates.each { |rate| csv << rate}
      end
      file.write(csv_rates)
      file.close
    end
  end
end

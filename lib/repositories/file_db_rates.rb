require 'csv'

module Repositories
  class FileDbRates
    def initialize(file_path)
      self.rates = load_rates_file(file_path)
    end

    def get_all_rates
      rates
    end

    private

    attr_accessor :rates

    def load_rates_file(file_path)
      [].tap do |entries|
        CSV.foreach(file_path) do |row|
          entries << ParkingCars::Entities::Rate.new(
            name: row[0],
            min_minutes_allowed: row[1].to_i,
            max_minutes_allowed: row[2].to_i,
            cost_per_hour: row[2].to_i
          )
        end
      end
    end
  end
end

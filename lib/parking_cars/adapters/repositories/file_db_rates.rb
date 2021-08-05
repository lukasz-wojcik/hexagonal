# frozen_string_literal: true

require 'csv'

module  ParkingCars
  module Adapters
    module Repositories
      class FileDbRates
        def initialize(file_path)
          self.file_path = file_path
        end

        def all_rates
          @all_rates ||= load_rates_file(file_path)
        end

        def rate_by_name(rate_name)
          found_rate = all_rates.detect { |rate| rate.name == rate_name }
          raise "Rate not found: #{rate_name}" unless found_rate

          found_rate
        end

        private

        attr_accessor :file_path

        def load_rates_file(file_path)
          [].tap do |entries|
            CSV.foreach(file_path) do |row|
              entries << ParkingCars::Domain::Entities::Rate.new(
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
  end
end

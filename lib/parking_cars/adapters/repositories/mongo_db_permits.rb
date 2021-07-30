# frozen_string_literal: true

module ParkingCars
  module Adapters
    module Repositories
      class MongoDbPermits
        def initialize
          self.model = ParkingCars::Adapters::Repositories::Persistence::Permit
        end

        def find(code)
          model.where(code: code).first
        end

        def create(resource_attributes)
          record = model.create(resource_attributes)
          to_entity(record)
        end

        private

        attr_accessor :model

        def to_entity(record)
          ParkingCars::Domain::Entities::Permit.new(
            code: record.code,
            rate_name: record.rate_name,
            plate_number: record.plate_number,
            start_date: record.start_date,
            end_date: record.end_date
          )
        end
      end
    end
  end
end

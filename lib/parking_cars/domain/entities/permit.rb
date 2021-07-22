module ParkingCars
  module Domain
    module Entities
      class Permit < Dry::Struct
        attribute :code, Types::Strict::String
        attribute :plate_number, Types::Strict::String
        attribute :rate_name, Types::Strict::String
        attribute :start_date, Types::Strict::DateTime
        attribute :end_date, Types::Strict::DateTime
      end
    end
  end
end

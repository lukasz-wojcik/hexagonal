# frozen_string_literal: true

module ParkingCars
  module Adapters
    module Repositories
      module Persistence
        class Permit
          include Mongoid::Document
          include Mongoid::Timestamps

          store_in collection: 'parking_cars_permits'

          field :code, type: String
          field :plate_number, type: String
          field :rate_name, type: String
          field :start_date, type: DateTime
          field :end_date, type: DateTime
        end
      end
    end
  end
end

# frozen_string_literal: true

module ParkingCars
  module Adapters
    module Repositories
      class InMemoryPermits
        def initialize
          self.db = {}
        end

        def find(code)
          db.fetch(code)
        end

        def create(resource_attributes)
          resource = ParkingCars::Domain::Entities::Permit.new(resource_attributes)
          db[resource.code] = resource
        end

        private

        attr_accessor :db
      end
    end
  end
end

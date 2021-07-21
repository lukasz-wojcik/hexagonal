module Repositories
  class InMemoryPermits
    def initialize
      self.db = {}
    end

    def find_by_id(id)
      db.fetch(id)
    end

    def create(resource_attributes)
      resource = ParkingCars::Entities::Permit.new(resource_attributes)
      db[resource.id] = resource
    end

    private

    attr_accessor :db
  end
end

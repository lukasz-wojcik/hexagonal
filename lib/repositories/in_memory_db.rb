
module Repositories
  class InMemoryDb
    def initialize
      @db = {}
    end

    def find_by_id(id)
      @db.fetch(id)
    end

    def create(resource)
      @db[resource.id] = resource
    end
  end
end

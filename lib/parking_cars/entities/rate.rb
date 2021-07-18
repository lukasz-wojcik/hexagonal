module ParkingCars
  module Entities
    class Rate < Dry::Struct
      attribute :name, Types::Strict::String
      attribute :cost_per_hour, Types::Strict::Integer
      attribute :min_minutes_allowed, Types::Strict::Integer
      attribute :max_minutes_allowed, Types::Strict::Integer
    end
  end
end

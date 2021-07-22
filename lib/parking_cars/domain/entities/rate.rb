module ParkingCars
  module Domain
    module Entities
      class Rate < Dry::Struct
        attribute :name, Types::Strict::String
        attribute :cost_per_hour, Types::Strict::Integer
        attribute :min_minutes_allowed, Types::Strict::Integer
        attribute :max_minutes_allowed, Types::Strict::Integer

        def allowed_duration?(duration)
          duration.between?(min_minutes_allowed, max_minutes_allowed)
        end

        def price_for_duration(duration)
          raise 'Invalid duration' unless allowed_duration?(duration)
          (duration.to_f / 60.0 * cost_per_hour)
        end
      end
    end
  end
end

# frozen_string_literal: true

module ParkingCars
  module Services
    class ObtainingRates
      def initialize(repository:)
        @repository = repository
      end

      def all_rates
        repository.all_rates
      end

      def rate_by_name(rate_name)
        repository.rate_by_name(rate_name)
      end

      private

      attr_reader :repository
    end
  end
end

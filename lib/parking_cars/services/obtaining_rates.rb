module ParkingCars
  module Services
    class ObtainingRates

      def initialize(repository:)
        @repository = repository
      end

      def get_all_rates
        repository.get_all_rates
      end

      private

      attr_reader :repository
    end
  end
end


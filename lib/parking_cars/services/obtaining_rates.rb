module ParkingCars
  module Services
    class ObtainingRates

      def initialize(repository: nil)
        @repository = repository || ApplicationConfig.obtaining_rates_repository
      end

      def get_all_rates
        repository.get_all_rates
      end

      def get_rate_by_name(rate_name)
        repository.get_rate_by_name(rate_name)
      end

      private

      attr_reader :repository
    end
  end
end


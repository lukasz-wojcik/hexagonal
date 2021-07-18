module ParkingCars
  module Services
    class ObtainingRates

      def initialize(data_source:)
        @data_source = data_source
      end

      def get_all_rates
        data_source.get_all_rates
      end

      private

      attr_reader :data_source
    end
  end
end


# frozen_string_literal: true

module ParkingCars
  class RatesFacade
    def initialize(rates_repository:)
      self.rates_repository = rates_repository
    end

    def all_rates
      Services::ObtainingRates.new(repository: rates_repository).all_rates
    end

    private

    attr_accessor :rates_repository
  end
end

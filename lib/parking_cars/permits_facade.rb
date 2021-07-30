# frozen_string_literal: true

module ParkingCars
  class PermitsFacade
    def issue_permit(permit_request)
      Services::IssuePermit.new(
        repository: repository,
        rates_facade: rates_facade,
        payments_facade: payments_facade
      ).issue_permit(permit_request)
    end

    def initialize(repository:, rates_facade:, payments_facade:)
      self.repository = repository
      self.rates_facade = rates_facade
      self.payments_facade = payments_facade
    end

    private

    attr_accessor :repository, :rates_facade, :payments_facade
  end
end

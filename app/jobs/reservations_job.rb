class ReservationsJob < ApplicationJob
  queue_as :reservations_queue

  # run daily
  def perform()
    client = HostAway.new
    reservations = client.get_reservations # use params to limit for past 2 weeks
    reservation.each do |reservation|
      mapped_params = HostAway.mapped_fields(reservation)
      Reservation.create(mapped_params)
    end
  end
end

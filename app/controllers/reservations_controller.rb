class ReservationsController < ApplicationController
  def index
    render json:  host_away_client.get_reservations # todo: add pagination
  end

  def update
    begin
      reservation = Reservation.find(params[:id])
    rescue Exception => error
      Rails.log.error(error)
      render json: { error: "Reservation with id: #{params[:id]} not found" }
      return
    end

    mapped_params = HostAway.mapped_fields(reservation_params)
    Reservation.create(mapped_params)
  end

  def create
    mapped_params = HostAway.mapped_fields(reservation_params)
    Reservation.create(mapped_params)
  end

  private

  def reservation_params
    # todo: strong params
  end

  def host_away_client
    @client ||= HostAway.new

    return @client
  end
end

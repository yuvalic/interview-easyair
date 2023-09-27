class Hostaway::Client
  def list_reservations
    HTTParty.get('https://api.hostaway.com/v1/reservations')
  end
end

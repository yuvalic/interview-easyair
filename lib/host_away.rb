class HostAway
  attr_accessor :client, :access_token, :expired_at

  HOST = ENV['HOSTAWAY_HOST'] + '/' + ENV['HOSTAWAY_VERSION'] + '/'


  MAPPED_FIELDS = {
    'checkInTime' => :check_in,
    'checkOutTime' => :checkut,
    'totalPrice' => :price,
    'guestName' => :guest_name,
    'listingMapId' => :listing_id,
    'status' => :status,
    'channelName' => :channel_name
  }

  def initialize
    @client = self
  end

  def get_reservations
    self.auth
    response = RestClient.get(HOST + 'reservations', headers: {'Authentication': "Bearer #{access_token}"})
    JSON.parse(response.body)
  rescue JSON::ParseError => error
    Rails.log.error("Unable to parse response: #{error.inspect}")
  end

  def auth
    return unless expired_token?

    response = RestClient.post(HOST + 'accessTokens', params: {
      grant_type: 'client_credentials',
      client_id: ENV[CLIENT_ID],
      client_credentials: ENV[CLIENT_SECRET]
    })
    response_json = JSON.parse(response.body)
    @access_token = response_json['access_token']
    @expired_at = Time.now.to_i + response_json['expired_in']
  rescue JSON::ParseError => error
    Rails.log.error("Unable to auth: #{error.inspect}")
  end

  def expired_token?
    @expired_at && Time.now.to_i > @expired_at
  end

  def self.mapped_fields(params)
    params.each_with_object({}) do |(k,v), memo|
      new_field = MAPPED_FIELDS.try(:[], k) || k
      memo[new_field] = v
    end
  end
end

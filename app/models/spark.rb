class Spark
  attr_reader :message

  def initialize(device, token)
    @device = device
    @token = token
  end

  def command(command)
    response = Net::HTTP.post_form(uri(command), {"access_token" => token})
    @message = response.message
    response.code == "200"
  end

  def query(query)
    response = Net::HTTP.get_response uri(query + "?access_token=#{token}")
    ActiveSupport::JSON.decode response.body
  end

  private

  attr_reader :token, :device

  def uri(command_or_query)
    path = "v1/devices/#{device}/#{command_or_query}"
    URI.parse("https://api.spark.io/#{path}")
  end
end

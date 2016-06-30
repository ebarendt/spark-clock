class Light
  include ActiveModel::Model

  attr_accessor :name, :device_id, :token

  def color
    api.query('color')['result']
  end

  def update(status)
    api.command(status)
  end

  def api
    @api ||= Spark.new(device_id, token)
  end
end
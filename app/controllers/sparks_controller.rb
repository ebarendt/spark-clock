class SparksController < ApplicationController
  before_action :setup_devices

  def index
  end

  def update
    @light = @lights.find { |light| light.device_id == params[:id] }
    if @light.update(params[:status])
      redirect_to sparks_path, notice: "#{@light.name} changed to #{params[:status]}"
    else
      flash.now[:error] = @light.api.message
      render 'index'
    end
  end

  private

  def setup_devices
    @lights = [
      Light.new(name: 'Emma', device_id: ENV['EMMA'], token: ENV['SPARK_TOKEN']),
      Light.new(name: 'Abby', device_id: ENV['ABBY'], token: ENV['SPARK_TOKEN'])
    ]
  end
end

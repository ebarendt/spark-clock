class SparksController < ApplicationController
  before_action :setup_device

  def show
    response = @spark.query("temperature")
    @temperature = sprintf("%.2f", response["result"])
    response = @spark.query("color")
    @color = response["result"]
    @core_info = response["coreInfo"]
  end

  def update
    if @spark.command(params[:status])
      redirect_to sparks_path, notice: "Changed to #{params[:status]}"
    else
      flash.now[:error] = spark.message
      render 'show'
    end
  end

  private

  def setup_device
    device = ENV.fetch("CLOCK")
    @spark = Spark.new(device)
  end
end

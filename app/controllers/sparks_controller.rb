class SparksController < ApplicationController
  before_action :setup_device

  def show
    spark = Spark.new(@device)
    response = spark.query("temperature")
    @temperature = sprintf("%.2f", response["result"])
    @core_info = response["coreInfo"]
  end

  def update
    spark = Spark.new(@device)
    if spark.command(params[:status])
      redirect_to sparks_path
    else
      flash.now[:error] = spark.message
      render 'show'
    end
  end

  private

  def setup_device
    @device = ENV.fetch("CLOCK")
  end
end

module SparksHelper
  def time_format(time)
    time = Time.parse time
    time.in_time_zone.strftime("%m/%d/%Y %l:%M:%S %p")
  end
end

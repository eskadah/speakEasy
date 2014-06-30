
class Event::AsClick < ActiveType::Record[Event]

  def initialize(params)
    clicked_time = params[:clicked_date] || Time.now
    super(:start => clicked_time,:end => clicked_time)
  end
  


end
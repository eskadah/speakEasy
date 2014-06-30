require 'prawn/table'

class AgendaPDF < Prawn::Document

attr_reader :events, :user

def initialize(events,user)
  super()
  @events = events
  @user = user
  header 
  move_down(20)
  table_content
end


def header
    text "#{user.name.titleize}'s Current Agenda",:size => 25, :style => :bold, :align => :center
end

def table_content
  table(event_rows) do 
    rows(0).font_style = :bold
    self.header = true
    self.row_colors = ['DDDDDD','FFFFFF']
  end
end

def event_rows
  [[ 'Title','Start Time','End Time','Comments']] + 
   events.to_a.map do |event|
    [event.title,event.start.to_s(:short),event.end.to_s(:short),event.comment]
  end
end

end
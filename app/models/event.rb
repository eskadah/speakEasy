class Event < ActiveRecord::Base
  

  before_save :build_all_day_event
  after_save :send_reminder


  validates_presence_of(:start,:end,:title)

  validate :valid_event

  belongs_to :speaker,foreign_key: 'user_id', class_name: User

  scope :future_events, ->{ where('start >= ?',Date.today) }
  scope :upcoming_events, ->(speaker_id){ future_events.where(:user_id => speaker_id).order('start asc').limit(5)}


  protected

  def valid_event
    if self.end && self.start
      errors.add(:end,'and Start times are Invalid') if self.end < self.start
    end
  end

  def build_all_day_event
    if all_day
      self.start = self.start.at_beginning_of_day
      self.end = self.start.at_end_of_day
    end
  end


  def one_day_before_event
    self.start.at_beginning_of_day - 1.day
  end


  def send_reminder
      Notification.send_reminder(speaker.email,title,start,self.end).deliver
  end

  handle_asynchronously :send_reminder, :run_at => Proc.new{|instance| instance.one_day_before_event}

end


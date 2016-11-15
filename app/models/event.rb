class Event < ApplicationRecord
  before_save :build_all_day_event
  after_save  :send_reminder

  validates_presence_of :start, :end, :title
  validate :valid_event

  belongs_to :speaker, foreign_key: 'user_id', class_name: User

  scope :future_events,   ->{ where('start >= ?', Date.today) }
  scope :upcoming_events, ->(speaker_id){ future_events.where(:user_id => speaker_id).order('start asc').limit(5) }

  protected

  def valid_event
    if self.end && self.start && !all_day  
      errors.add(:end,'and Start times are Invalid') if self.end < self.start
    end
  end

  def build_all_day_event
    if all_day
      self.start = self.start.at_beginning_of_day
      self.end = self.start.at_end_of_day
    end
  end

  def notification_date
    (start.at_beginning_of_day - 1.day)
  end

  def send_reminder
    Notification.send_reminder(speaker.email, self.id).deliver_later(wait_until: notification_date)
    SmsNotificationJob.set(wait_until: notification_date).perform_later(title, speaker.phone_number) if speaker.phone_number?
  end
end


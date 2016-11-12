class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :start, :end, :all_day, :url,
  :title, :comment, :created_at, :updated_at, :user_id

  def url
    event_path(object)
  end
end

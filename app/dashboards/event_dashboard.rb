require "administrate/base_dashboard"

class EventDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    speaker: Field::BelongsTo.with_options(class_name: "User"),
    id: Field::Number,
    start: Field::DateTime,
    end: Field::DateTime,
    all_day: Field::Boolean,
    title: Field::String,
    comment: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    user_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :speaker,
    :id,
    :start,
    :end,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :speaker,
    :id,
    :start,
    :end,
    :all_day,
    :title,
    :comment,
    :created_at,
    :updated_at,
    :user_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :speaker,
    :start,
    :end,
    :all_day,
    :title,
    :comment,
    :user_id,
  ].freeze

  # Overwrite this method to customize how events are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(event)
  #   "Event ##{event.id}"
  # end
end

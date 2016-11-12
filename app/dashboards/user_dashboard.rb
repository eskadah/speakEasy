require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    id: Field::Number,
    password_digest: Field::String,
    name: Field::String,
    email: Field::String,
    username: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    time_zone: Field::String,
    github_id: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :events,
    :id,
    :name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :events,
    :id,
    :name,
    :email,
    :username,
    :created_at,
    :updated_at,
    :time_zone,
    :github_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :events,
    :password_digest,
    :name,
    :email,
    :username,
    :time_zone,
    :github_id,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    user.name
  end
end

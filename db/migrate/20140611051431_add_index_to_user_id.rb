class AddIndexToUserId < ActiveRecord::Migration
  def change
    add_index('events', 'user_id')
  end
end

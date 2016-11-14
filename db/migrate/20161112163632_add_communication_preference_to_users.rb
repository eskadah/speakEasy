class AddCommunicationPreferenceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :communication_preference, :integer, default: 0
  end
end

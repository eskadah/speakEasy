class ChangeCommunicationPreferencesToString < ActiveRecord::Migration[5.0]
  def change
    change_column(:users, :communication_preference, :string, limit: 2)
  end
end

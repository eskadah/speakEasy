class AddGithubidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :github_id, :string
    add_index :users, :github_id
  end
end

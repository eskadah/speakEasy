class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :end
      t.boolean :all_day,:default => false
      t.string :title
      t.text :comment

      t.timestamps
    end
  end
end

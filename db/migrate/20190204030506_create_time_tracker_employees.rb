class CreateTimeTrackerEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :time_tracker_employees do |t|
      t.string :annotation
      t.references :user, foreign_key: true
      t.column :start_at, :datetime
      t.column :end_at, :datetime
      t.integer :duration

      t.timestamps
    end
  end
end

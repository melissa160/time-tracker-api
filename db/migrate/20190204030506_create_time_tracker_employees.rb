class CreateTimeTrackerEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :time_tracker_employees do |t|
      t.string :type
      t.references :user, foreign_key: true
      t.column :tdatetime, :datetime
      t.string :tag

      t.timestamps
    end
  end
end

class RenameAndRemoveFieldsToTimeTrackerEmployee < ActiveRecord::Migration[5.1]
  def change
    rename_column :time_tracker_employees, :type, :type_tracker
    remove_column :time_tracker_employees, :tdatetime, :datetime
  end
end

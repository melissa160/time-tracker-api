class TimeTrackerEmployee < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true

  scope :search_by_employee, lambda{|params, user_id| where(:created_at => params["start_at"]..params["end_at"], :user_id => user_id)}

  scope :search_by_employees, lambda{|params| where(:created_at => params["start_at"]..params["end_at"], :user_id => params["user_ids"])}
end

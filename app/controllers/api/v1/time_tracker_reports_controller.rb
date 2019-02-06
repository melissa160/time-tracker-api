module Api::V1
  class TimeTrackerReportsController < ApplicationController
    def report_by_user
      authorize! :employee
      @time_trackers = TimeTrackerEmployee.search_by_employee(params, @current_user)  
      render json: @time_trackers
    end

    def report_by_users
      authorize! :admin
      @time_trackers = TimeTrackerEmployee.search_by_employees(params)
      render json: @time_trackers
    end
  end
end
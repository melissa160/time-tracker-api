module Api::V1
  class TimeTrackerEmployeesController < ApplicationController
    def in
      authorize! :admin
      time_tracker_data = params_with_type("in")
      save_time_tracker_employee(time_tracker_data)
    end

    def out
      authorize! :admin
      time_tracker_data = params_with_type("out")
      save_time_tracker_employee(time_tracker_data)
    end

    private

    def params_with_type(type_tracker)
      params[:time_tracker_employee].merge("type_tracker" => type_tracker).permit(:user_id, :tag, :type_tracker)
    end

    def save_time_tracker_employee(data)
      @time_tracker_employee = TimeTrackerEmployee.new(data)

      if @time_tracker_employee.save
        render json: @time_tracker_employee, status: :created, location: api_v1_time_tracker_employees_in_url(@time_tracker_employee)
      else
        render json: @time_tracker_employee.errors, status: :unprocessable_entity
      end
    end
  end
end
module Api::V1
  class TimeTrackerEmployeesController < ApplicationController
    def in
      authorize! :admin
      puts "aaaaaaaaaaaaaaaaaaaaaa"
      paramss = params[:time_tracker_employee].merge("type_tracker" => "in")
      #parameterss = time_tracker_params.merge(:type => "in")
      #parameterss.inspect
      puts "bbbbbbbbbbbbbbbb"
      puts paramss.inspect
      @time_tracker_employee = TimeTrackerEmployee.new(time_tracker_params)

      if @time_tracker_employee.save
        render json: @time_tracker_employee, status: :created, location: api_v1_time_tracker_employees_in_url(@time_tracker_employee)
      else
        render json: @time_tracker_employee.errors, status: :unprocessable_entity
      end
    end

    private

    def time_tracker_params
      params[:time_tracker_employee].merge("type_tracker" => "in").permit(:user_id, :tag, :type_tracker)
    end
  end
end
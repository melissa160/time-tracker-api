module Api::V1
  class TimeTrackerEmployeeController < ApplicationController
    before_action :set_time_tracker, only: [:show, :update, :destroy]

    # GET /time-tracker-employees
    def index
      @todos = current_user.todos
  
      render json: @todos
    end
  
    # GET /time-tracker-employees/1
    def show
      render json: @todo
    end
  
    # POST /time-tracker-employees
    # siempre se crea con la fecha de inicio
    def create
      @todo = current_user.todos.build(time_tracker_params)
  
      if @todo.save
        render json: @todo, status: :created, location: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /time-tracker-employees/1
    # para mandar la fecha fin
    def update
      if @todo.update(time_tracker_params)
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /time-tracker-employees/1
    def destroy
      @todo.destroy
    end
  
    private
  
    def set_time_tracker
      @todo = current_user.todos.find(params[:id])
    end
  
    def time_tracker_params
      params.require(:todo).permit(:title)
    end
end
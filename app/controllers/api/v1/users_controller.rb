module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    def index
      authorize! :admin
      @users = User.all
      render json: @users
    end

    def show
      authorize! :employee
      render json: @user
    end

    def create
      authorize! :admin
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: api_v1_user_url(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      authorize! :admin
      if @user.update(user_params_update)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      authorize! :admin
      @user.destroy
      render json: @user
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      {name: params[:name], email: params[:email], password: params[:password], age: params[:age], address: params[:address], department: params[:department]}
    end

    def user_params_update
      {name: params[:name], email: params[:email], age: params[:age], address: params[:address], department: params[:department]}
    end
  end
end
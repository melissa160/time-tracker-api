module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]
    wrap_parameters :user, include: [:password]

    def index
      @users = User.all
      render json: @users
    end

    def show
      render json: @user
    end

    def create
      @user = User.new(user_params)
      @user.password

      if @user.save
        render json: @user, status: :created, location: api_v1_user_url(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params_update)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
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
module Api::V1
  class AuthController < ApplicationController
    skip_before_action :authenticate_user

    def create
      token_command = AuthUserCommand.call(*params.slice(:email, :password).values)

      if token_command.success?
        render json: { token: token_command.result }
      else
        render json: { error: token_command.errors }, status: :unauthorized
      end
    end
  end
end
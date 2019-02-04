module Api::V1
  class AuthController < ApplicationController
    def create
      token_command = AuthenticateUserCommand.call(*params.slice(:email, :password).values)

      if token_command.success?
        render json: { token: token_command.result }
      else
        render json: { error: token_command.errors }, status: :unauthorized
      end
    end
  end
end
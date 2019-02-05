class ApplicationController < ActionController::API
  include TokenAuthenticable
  include AdminAuthorizable

  rescue_from ActiveRecord::RecordNotFound, with: -> { render json: { error: 'Not found' }, status: :not_found }
end

class NotPermittedException < StandardError; end

module AdminAuthorizable
  extend ActiveSupport::Concern

  included do
    rescue_from NotPermittedException, with: -> { render json: { error: 'Not Permitted' }, status: :forbidden }
  end

  # :reek:ControlParameter
  def authorize!(action)
    raise NotPermittedException if action != :employee && !current_user.admin?
    true
  end
end
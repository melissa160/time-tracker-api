class NotPermittedException < StandardError; end

module AdminAuthorizable
  extend ActiveSupport::Concern

  included do
    rescue_from NotPermittedException, with: -> { render json: { error: 'Do not have permission to perform this action' }, status: :forbidden }
  end

  # :reek:ControlParameter
  def authorize!(action)
    raise NotPermittedException if action != :employee && !current_user.admin?
    true
  end
end
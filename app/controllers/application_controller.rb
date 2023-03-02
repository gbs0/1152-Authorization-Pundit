class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  after_action :verify_authorized, expect: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::PolicyScopingNotPerformedError, with: :unpermitted_policy

  private

  def unpermitted_policy
    flash[:notice] = "Please, create o policy for this route!"
  end

  def user_not_authorized
    flash[:alert] = "You're NOT authorized to perform this action!"
    redirect_to root_path
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end

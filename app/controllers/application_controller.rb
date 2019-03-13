class ApplicationController < ActionController::Base
  before_action :set_locale
  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please"
    redirect_to login_url
  end
end

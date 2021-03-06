class ApplicationController < ActionController::Base
  include Notification

  protect_from_forgery

  before_filter :set_locale
  after_filter :flash_to_cookie

  def set_locale
    lang = unless params[:lang].blank?
      params[:lang].downcase
    else
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
    I18n.locale = lang if I18n.available_locales.include?(lang.to_sym)
  rescue
    # use default
  end
end

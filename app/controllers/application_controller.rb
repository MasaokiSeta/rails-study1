class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required
  before_action :set_locale

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def login_required
    redirect_to login_url unless current_user
  end
  def set_locale
    I18n.locale = current_user&.locale || :ja # ログインしていなければ日本語
    logger.debug "ローケルが#{I18n.locale}に設定されました。"
    logger.fatal "fatal error test"
    # 実はRails.application.config&.custom_logger.fatal "custom test"
    # A&.BはAがnot nilの場合Bが流れるのでBが定義なしでも流れる
    Rails.application.config.custom_logger.fatal "custom test" if Rails.application.config.respond_to? :custom_logger
  end
end

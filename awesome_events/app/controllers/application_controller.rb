class ApplicationController < ActionController::Base
  before_action :authenticate
  # ヘルパーメソッドを定義
  # セッション情報の取り扱いは、コントローラー層で行うのでhelperファイルではなく、コントローラーに記述
  # ApplicationHelperはビューの表示に特化したメソッドを定義する
  helper_method :logged_in?, :current_user

  # recue_fromは下から上に評価される
  # rescue_from Exceptionは全てのエラーを捕捉するので一番上に記述する
  rescue_from Exception, with: :error500
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

  private

  def logged_in?
    !!current_user
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, alert: 'ログインしてください'
  end

  # エラー発生時にHTML以外でのレスポンスを要求された場合にテンプレートが見つからないエラーが発生する
  # formats: [:html]を指定することで、HTML以外のレスポンスを要求された場合にはHTML形式でエラーページを返す
  def error404(e)
    render "error404", status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join("\n")
    render "error500", status: 500, formats: [:html]
  end
end

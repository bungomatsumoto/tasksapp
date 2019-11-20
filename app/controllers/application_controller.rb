class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :must_login

  # Forbiddenというエラーを実装する
  # class Forbidden < ActionController::ActionControllerError
  # end
  #
  # # Forbiddenが発生したらresucue403メソッド
  # rescue_from Forbidden, with: :rescue403

  private

    # エラー発生時はapp/errors/forbbiden.html.erb を表示し、HTTPステータス403を返す
    def rescue403
      # @exception = e
      render template: 'errors/forbidden.html'
    end

end

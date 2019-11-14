module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def must_login
    if current_user == nil
      redirect_to root_path
    end
  end
end

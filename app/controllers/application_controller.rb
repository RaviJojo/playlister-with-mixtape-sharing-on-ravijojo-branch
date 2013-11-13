class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :login_required

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :artist_name,:genre_names)
    end

    def login_required
      if !logged_in?
        redirect_to login_path and return
      end
    end

    def logged_in?
      !!current_user
    end
    helper_method :logged_in?

    def current_user
      current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def login(id)
      session[:user_id] = id
    end
end

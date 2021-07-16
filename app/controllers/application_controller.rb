class ApplicationController < ActionController::Base
    # get and return current user from session

    helper_method :current_user
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    # notice that logged_in calls the current_user method, which in turn either returns the current user or 
    # nil if there is no session[user_id] 
    helper_method :logged_in?
    def logged_in?
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action."
            redirect_to login_path
        end
    end

end

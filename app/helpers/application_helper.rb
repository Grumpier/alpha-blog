module ApplicationHelper

    # helper methods
    # this is to display an image associated with email address at gravatar website
    def gravatar_for(user, options = { size: 80 })
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block" )
    end

    # get and return current user from session
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    # notice that logged_in calls the current_user method, which in turn either returns the current user or 
    # nil if there is no session[user_id] 
    def logged_in?
        !!current_user
    end

end

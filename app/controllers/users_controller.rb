class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # flash helper for displaying a message
            welcome = "Welcome, #{@user.username}, to Alpha Blog!" 
            flash[:notice] = welcome
            #  calls the show action - need to use @article rather than article_path to grab the new id of the object 
            redirect_to articles_path
        else
            # redraws the new action view
            render 'new'
        end      
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
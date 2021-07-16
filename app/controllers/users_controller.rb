class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :require_same_user, only: [:edit, :update]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # flash helper for displaying a message
            welcome = "Welcome, #{@user.username}, to Alpha Blog!" 
            flash[:notice] = welcome
            session[:user_id] = @user.id
            #  calls the show action - need to use @article rather than article_path to grab the new id of the object 
            redirect_to articles_path
        else
            # redraws the new action view
            render 'new'
        end      
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def edit
    end

    def update
        if @user.update(user_params)
            # flash helper for displaying a message
            flash[:notice] = "Update successfull."
            #  calls the show action
            redirect_to user_path(@user)
        else
            # redraws the edit action view
            render 'edit'
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You are not authorized for this action."
            redirect_to current_user
        end
    end
end
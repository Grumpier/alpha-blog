class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def show
  end
  
  def new
    @article = Article.new
  end
  
  def edit
  end

  def create
    # not needed to be so explicit
    #@article = Article.new(title: params[:article][:title], description: params[:article][:description])
    # instead rails can interpret what attributes are needed but needs to know what is allowed to be passed ("white listed")
    # NEED CODE TO TRAP FOR VALIDATION!
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      # flash helper for displaying a message
      flash[:notice] = "Article was created successfully."
      #  calls the show action - need to use @article rather than article_path to grab the new id of the object 
      redirect_to @article
    else
      # redraws the new action view
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      # flash helper for displaying a message
      flash[:notice] = "Article was updated successfully."
      #  calls the show action
      redirect_to article_path
    else
      # redraws the edit action view
      render 'edit'
    end
   end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private 

  def set_article
    if Article.exists?(params[:id])
      @article = Article.find(params[:id])
    else
      flash[:notice] = "Article not found."
      @articles = Article.all
      render 'index'
    end
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end
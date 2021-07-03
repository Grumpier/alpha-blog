class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    if Article.exists?(params[:id])
      @article = Article.find(params[:id])
    end
  end
end
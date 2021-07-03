class ArticlesController < ApplicationController
  def show
    if Article.exists?(params[:id])
      @article = Article.find(params[:id])
    end
  end
end
class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end
  def show
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    @article.author = current_user
    if @article.save
      flash[:success] = "Article has been created."
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created."
      render :new
    end
  end
  def edit
    unless @article.author == current_user
      flash[:danger] = "You are not authorized to edit this article."
      redirect_to root_path
    end
  end
  def update
    unless @article.author == current_user
      flash[:danger] = "You are not authorized to edit this article."
      redirect_to root_path
    end

    if @article.update(article_params)
      flash[:success] = "Article has been updated successfully."
      redirect_to @article
    else
      flash.now[:danger] = "Article could not be updated."
      render :edit
    end
  end

  def destroy
    unless @article.author == current_user
      flash[:danger] = "You are not authorized to delete this article."
      redirect_to root_path
    else
      if @article.destroy
        flash[:success] = "Article has been deleted."
      else
        flash[:danger] = "Article could not be deleted."
      end
        redirect_to articles_path
    end
  end

  protected

  def resource_not_found
    message = "The article you are looking for could not be found"
    flash[:danger] = message
    redirect_to root_path
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :body)
  end
end

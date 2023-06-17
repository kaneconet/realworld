class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: { article: @article.as_json(only: [:slug, :title, :description, :body, :created_at, :updated_at]) }, status: :created
    else
      render json: { errors: @article.errors}, status: :unprocessable_entity
    end
  end

  def show
    render json: { article: @article.as_json(only: [:slug, :title, :description, :body, :created_at, :updated_at]) }
  end

  def update
    if @article.update(article_params)
      render json: { article: @article.as_json(only: [:slug, :title, :description, :body, :created_at, :updated_at]) }
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, :body)
  end

  def set_article
    @article = Article.find_by(slug: params[:slug])
  end
end

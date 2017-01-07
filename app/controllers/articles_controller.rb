class ArticlesController < ApplicationController

  # GET /articles/new

  def new
    @article = Article.new
  end

  # POST /articles

  def create
    @article = Article.new(article_params)
    if @article.save
      # Do something
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # GET /articles/:id

  def show
    @article = Article.find(params[:id])
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end
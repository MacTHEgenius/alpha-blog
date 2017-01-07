class ArticlesController < ApplicationController

  # GET /articles/new

  def new
    @article = Article.new
  end

  # GET /articles/:id/edit

  def edit
    @article = Article.find(params[:id])
  end

  # GET /articles/

  def index
    @articles = Article.all
  end

  # POST /articles

  def create
    @article = Article.new(article_params)
    if @article.save
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

  # PATCH - PUT /articles/:id

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end
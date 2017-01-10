class ArticlesController < ApplicationController
  before_action :get_article, only: [:edit, :update, :show, :destroy]

  # GET /articles/new

  def new
    @article = Article.new
  end

  # GET /articles/:id/edit

  def edit
    #@article = Article.find(params[:id])
  end

  # GET /articles

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # POST /articles

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # GET /articles/:id

  def show
    #@article = Article.find(params[:id])
  end

  # PATCH - PUT /articles/:id

  def update
    #@article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  # DELETE /articles/:id

  def destroy
    #@article = Article.find(params[:id])
    @article.destroy

    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def get_article
      @article = Article.find(params[:id])
    end

end
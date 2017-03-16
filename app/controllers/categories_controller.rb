class CategoriesController < ApplicationController

  # GET /categories/new

  def new
    @category = Category.new
  end

  # GET /categories

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  # POST /categories

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  # /categories/:id

  # GET
  def show

  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

end
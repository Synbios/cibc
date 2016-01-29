class TourCategoriesController < ApplicationController
  before_action :set_tour_category, only: [:show, :edit, :update, :destroy]

  def index
    @tour_categories = TourCategory.all
    render layout: "shijiebang"
  end

  def show
    render layout: "shijiebang"
  end

  def new
    @tour_category = TourCategory.new
    render layout: "shijiebang"
  end

  def edit
    render layout: "shijiebang"
  end

  def create
    @tour_category = TourCategory.new(tour_category_params)

    respond_to do |format|
      if @tour_category.save
        format.html { redirect_to @tour_category, notice: 'TourCategory was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tour_category.update(tour_category_params)
        format.html { redirect_to @tour_category, notice: 'TourCategory was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tour_category.destroy
    respond_to do |format|
      format.html { redirect_to tour_categories_url, notice: 'TourCategory was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_category
      @tour_category = TourCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_category_params
      params.require(:tour_category).permit(:name, :icon, :order)
    end
end

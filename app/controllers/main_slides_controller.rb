class MainSlidesController < ApplicationController
  before_action :set_main_slide, only: [:show, :edit, :update, :destroy]

  def index
    @main_slides = MainSlide.all
    render layout: "shijiebang"
  end

  def show
    render layout: "shijiebang"
  end

  def new
    @main_slide = MainSlide.new
    render layout: "shijiebang"
  end

  def edit
    render layout: "shijiebang"
  end

  def create
    @main_slide = MainSlide.new(main_slide_params)

    respond_to do |format|
      if @main_slide.save
        format.html { redirect_to @main_slide, notice: 'MainSlide was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @main_slide.update(main_slide_params)
        format.html { redirect_to @main_slide, notice: 'MainSlide was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @main_slide.destroy
    respond_to do |format|
      format.html { redirect_to main_slides_url, notice: 'MainSlide was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_slide
      @main_slide = MainSlide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_slide_params
      params.require(:main_slide).permit(:name, :image, :order, :active)
    end
end

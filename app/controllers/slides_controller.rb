class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  # GET /slides
  # GET /slides.json
  def index
    @tour = Tour.find_by_id params[:tour_id]
    @slides = @tour.slides
    render layout: "shijiebang"
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
    render layout: "shijiebang"
  end

  # GET /slides/new
  def new
    @tour = Tour.find_by_id(params[:tour_id]).becomes(Tour)
    @slide = Slide.new
    render layout: "shijiebang"
  end

  # GET /slides/1/edit
  def edit
    render layout: "shijiebang"
  end

  # POST /slides
  # POST /slides.json
  def create
    @tour = Tour.find_by_id(params[:tour_id])
    @slide = Slide.new(slide_params)
    @slide.tour = @tour

    respond_to do |format|
      if @slide.save
        format.html { redirect_to @slide, notice: 'Slide was successfully created.' }
        format.json { render :show, status: :created, location: @slide }
      else
        format.html { render :new }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slides/1
  # PATCH/PUT /slides/1.json
  def update
    respond_to do |format|
      if @slide.update(slide_params)
        format.html { redirect_to @slide, notice: 'Slide was successfully updated.' }
        format.json { render :show, status: :ok, location: @slide }
      else
        format.html { render :edit }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to tour_slides_url(@slide.tour), notice: 'Slide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slide
      @slide = Slide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slide_params
      params.require(:slide).permit(:name, :tour_id, :image)
    end
end

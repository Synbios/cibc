class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]
  before_action :set_locale
  #protect_from_forgery except: :calendar

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
    render layout: "shijiebang"
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    render layout: "shijiebang"
  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour = Tour.new(tour_params)

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: @tour }
      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def maoxian88
    render layout: "unify"
  end

  def maoxian_vinery
    render layout: "unify"
  end

  def au13
    render layout: "unify-tour"
  end

  def west_au
    render layout: "unify-tour"
  end

  def ax12
    render "ax12_wx", layout: "unify-tour"
  end
  def ax13
    render layout: "shijiebang"
  end

  def ax16
    render layout: "unify-tour"
  end

  def sample
    render layout: "shijiebang"
  end

  def huang
    render layout: "shijiebang"
  end

  def round
    render "round3", layout: "round"
  end

  def calendar
    respond_to do |format|
      format.js {
        @departures = Departure.all
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:name, :slider_subtitle, :tour_map, :features, :terms)
    end

    
end

class HighLightsController < ApplicationController
  before_action :set_high_light, only: [:show, :edit, :update, :destroy]

  # GET /high_lights
  # GET /high_lights.json
  def index
    @tour = Tour.find_by_id params[:tour_id]
    @high_lights = @tour.high_lights
    render layout: "shijiebang"
  end

  # GET /high_lights/1
  # GET /high_lights/1.json
  def show
    render layout: "shijiebang"
  end

  # GET /high_lights/new
  def new
    @tour = Tour.find_by_id params[:tour_id]
    @high_light = HighLight.new
    render layout: "shijiebang"
  end

  # GET /high_lights/1/edit
  def edit
    render layout: "shijiebang"
  end

  # POST /high_lights
  # POST /high_lights.json
  def create
    @tour = Tour.find_by_id params[:tour_id]
    @high_light = HighLight.new(high_light_params)
    @high_light.tour = @tour
    respond_to do |format|
      if @high_light.save
        format.html { redirect_to @high_light, notice: 'High light was successfully created.' }
        format.json { render :show, status: :created, location: @high_light }
      else
        format.html { render :new }
        format.json { render json: @high_light.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /high_lights/1
  # PATCH/PUT /high_lights/1.json
  def update
    respond_to do |format|
      if @high_light.update(high_light_params)
        format.html { redirect_to @high_light, notice: 'High light was successfully updated.' }
        format.json { render :show, status: :ok, location: @high_light }
      else
        format.html { render :edit }
        format.json { render json: @high_light.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /high_lights/1
  # DELETE /high_lights/1.json
  def destroy
    @high_light.destroy
    respond_to do |format|
      format.html { redirect_to high_lights_url, notice: 'High light was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_high_light
      @high_light = HighLight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def high_light_params
      params.require(:high_light).permit(:name, :tour_id, :image)
    end
end

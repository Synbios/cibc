class DeparturesController < ApplicationController
  before_action :set_departure, only: [:show, :edit, :update, :destroy]

  # GET /departures
  # GET /departures.json
  def index
    @route = Route.find_by_id params[:route_id]
    @departures = @route.departures
    render layout: "shijiebang"
  end

  # GET /departures/1
  # GET /departures/1.json
  def show
    render layout: "shijiebang"
  end

  # GET /departures/new
  def new
    @route = Route.find_by_id params[:route_id]
    @departure = Departure.new
    render layout: "shijiebang"
  end

  # GET /departures/1/edit
  def edit
    render layout: "shijiebang"
  end

  # POST /departures
  # POST /departures.json
  def create
    @route = Route.find_by_id params[:route_id]
    @departure = Departure.new(departure_params)
    @departure.route = @route
    respond_to do |format|
      if @departure.save
        format.html { redirect_to @departure, notice: 'Departure was successfully created.' }
        format.json { render :show, status: :created, location: @departure }
      else
        format.html { render :new }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departures/1
  # PATCH/PUT /departures/1.json
  def update
    respond_to do |format|
      if @departure.update(departure_params)
        format.html { redirect_to @departure, notice: 'Departure was successfully updated.' }
        format.json { render :show, status: :ok, location: @departure }
      else
        format.html { render :edit }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departures/1
  # DELETE /departures/1.json
  def destroy
    @departure.destroy
    respond_to do |format|
      format.html { redirect_to route_departures_url(@departure.route), notice: 'Departure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departure
      @departure = Departure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departure_params
      params.require(:departure).permit(:tour_id, :start_time, :seats, :price)
    end
end

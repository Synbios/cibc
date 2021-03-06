class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # GET /routes
  # GET /routes.json
  def index
    @tour = Tour.find_by_id(params[:tour_id])
    render layout: "shijiebang"
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @routes = [@route]
    @this_month = Time.now
    @next_month = @this_month + 1.month
    @next_next_month = @this_month + 2.month
    @tour = @route.tour
    render layout: "shijiebang"
  end

  # GET /routes/new
  def new
    @tour = Tour.find_by_id params[:tour_id]
    @route = Route.new
    render layout: "shijiebang"
  end

  # GET /routes/1/edit
  def edit
    render layout: "shijiebang"
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)
    @route.tour = Tour.find_by_id params[:tour_id]
    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to tour_routes_url(@route.tour), notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      params.require(:route).permit(:tour_id, :name, :descriptions)
    end


end

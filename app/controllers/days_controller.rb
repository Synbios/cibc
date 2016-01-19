class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :destroy]

  # GET /days
  # GET /days.json
  def index
    @route = Route.find_by_id(params[:route_id]) 
    @days = @route.days
    render layout: "shijiebang"
  end

  # GET /days/1
  # GET /days/1.json
  def show
  end

  # GET /days/new
  def new
    @route = Route.find_by_id params[:route_id]
    @day = Day.new(route_id: @route.id)
    render layout: "shijiebang"
  end

  # GET /days/1/edit
  def edit
    render layout: "shijiebang"
  end

  # POST /days
  # POST /days.json
  def create
    @day = Day.new(day_params)
    @day.route = Route.find_by_id params[:route_id]
    respond_to do |format|
      if @day.save
        @day.route.reorder
        format.html { redirect_to @day, notice: 'Day was successfully created.' }
        format.json { render :show, status: :created, location: @day }
      else
        format.html { render :new }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    respond_to do |format|
      if @day.update(day_params)
        @day.route.reorder
        format.html { redirect_to @day, notice: 'Day was successfully updated.' }
        format.json { render :show, status: :ok, location: @day }
      else
        format.html { render :edit }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /days/1
  # DELETE /days/1.json
  def destroy
    @route = @day.route
    @day.destroy
    @route.reorder
    respond_to do |format|
      format.html { redirect_to route_days_url(@route), notice: 'Day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day
      @day = Day.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_params
      params.require(:day).permit(:number, :modal_title, :modal_content, :previous_day_id, :next_day_id, :icon)
    end
end

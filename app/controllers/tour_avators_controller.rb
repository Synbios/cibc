class TourAvatorsController < ToursController
  #protect_from_forgery except: :calendar

  # GET /tours
  # GET /tours.json
  def index
    @tour_avators = TourAvator.all
    render layout: "shijiebang"
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    @tour_avator = TourAvator.find_by_id params[:id]
    @shards = @tour_avator.shards.order(:order)
    render layout: "shijiebang"
  end

  # GET /tours/new
  def new
    @tour_avator = TourAvator.new
    render layout: "shijiebang"
  end

  # GET /tours/1/edit
  def edit
    @tour_avator = TourAvator.find_by_id params[:id]
    render layout: "shijiebang"
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour_avator = TourAvator.new(tour_avator_params)

    respond_to do |format|
      if @tour_avator.save
        format.html { redirect_to @tour_avator, notice: 'tour_avator was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    @tour_avator = TourAvator.find_by_id params[:id]
    respond_to do |format|
      if @tour_avator.update(tour_avator_params)
        format.html { redirect_to @tour_avator, notice: 'tour_avator was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour_avator = TourAvator.find_by_id params[:id]
    @tour_avator.destroy
    respond_to do |format|
      format.html { redirect_to tours_url, notice: 'tour_avator was successfully destroyed.' }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_avator_params
      params.require(:tour_avator).permit(:name, :slider_subtitle, 
        :features, :order, :cover_title, :cover_info, 
        :cover_image_large, :cover_image_small_a, :cover_image_small_b, :cover_image_small_c, :cover_image_small_d, 
        :wechat_share_title, :wechat_share_description, :wechat_share_icon, 
        :content_image, :tour_category_ids => [])
    end

    
end

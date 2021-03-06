require 'test_helper'

class DeparturesControllerTest < ActionController::TestCase
  setup do
    @departure = departures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create departure" do
    assert_difference('Departure.count') do
      post :create, departure: { price: @departure.price, seats: @departure.seats, start_time: @departure.start_time, tour_id: @departure.tour_id }
    end

    assert_redirected_to departure_path(assigns(:departure))
  end

  test "should show departure" do
    get :show, id: @departure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @departure
    assert_response :success
  end

  test "should update departure" do
    patch :update, id: @departure, departure: { price: @departure.price, seats: @departure.seats, start_time: @departure.start_time, tour_id: @departure.tour_id }
    assert_redirected_to departure_path(assigns(:departure))
  end

  test "should destroy departure" do
    assert_difference('Departure.count', -1) do
      delete :destroy, id: @departure
    end

    assert_redirected_to departures_path
  end
end

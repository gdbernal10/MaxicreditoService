require 'test_helper'

class RatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get create_from_collection" do
    get :create_from_collection
    assert_response :success
  end

  test "should get index_by_product" do
    get :index_by_product
    assert_response :success
  end

end

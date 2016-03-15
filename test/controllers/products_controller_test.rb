require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get create_from_collection" do
    get :create_from_collection
    assert_response :success
  end

  test "should get update_by_code" do
    get :update_by_code
    assert_response :success
  end

  test "should get show_all" do
    get :show_all
    assert_response :success
  end

end

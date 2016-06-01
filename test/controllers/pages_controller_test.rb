require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get cross_country" do
    get :cross_country
    assert_response :success
  end

  test "should get alpine" do
    get :alpine
    assert_response :success
  end

  test "should get biathlon" do
    get :biathlon
    assert_response :success
  end

  test "should get nordic_combined" do
    get :nordic_combined
    assert_response :success
  end

end

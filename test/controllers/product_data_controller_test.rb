require 'test_helper'

class ProductDataControllerTest < ActionController::TestCase
  setup do
    @product_datum = product_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_datum" do
    assert_difference('ProductDatum.count') do
      post :create, product_datum: { price: @product_datum.price, product_id: @product_datum.product_id, quantity: @product_datum.quantity }
    end

    assert_redirected_to product_datum_path(assigns(:product_datum))
  end

  test "should show product_datum" do
    get :show, id: @product_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_datum
    assert_response :success
  end

  test "should update product_datum" do
    patch :update, id: @product_datum, product_datum: { price: @product_datum.price, product_id: @product_datum.product_id, quantity: @product_datum.quantity }
    assert_redirected_to product_datum_path(assigns(:product_datum))
  end

  test "should destroy product_datum" do
    assert_difference('ProductDatum.count', -1) do
      delete :destroy, id: @product_datum
    end

    assert_redirected_to product_data_path
  end
end

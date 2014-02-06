require 'test_helper'

class IvasControllerTest < ActionController::TestCase
  setup do
    @iva = ivas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ivas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create iva" do
    assert_difference('Iva.count') do
      post :create, iva: { iva: @iva.iva }
    end

    assert_redirected_to iva_path(assigns(:iva))
  end

  test "should show iva" do
    get :show, id: @iva
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @iva
    assert_response :success
  end

  test "should update iva" do
    patch :update, id: @iva, iva: { iva: @iva.iva }
    assert_redirected_to iva_path(assigns(:iva))
  end

  test "should destroy iva" do
    assert_difference('Iva.count', -1) do
      delete :destroy, id: @iva
    end

    assert_redirected_to ivas_path
  end
end

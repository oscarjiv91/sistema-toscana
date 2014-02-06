require 'test_helper'

class SalesmenControllerTest < ActionController::TestCase
  setup do
    @salesman = salesmen(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salesmen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salesman" do
    assert_difference('Salesman.count') do
      post :create, salesman: { name: @salesman.name, phone: @salesman.phone, supplier_id: @salesman.supplier_id }
    end

    assert_redirected_to salesman_path(assigns(:salesman))
  end

  test "should show salesman" do
    get :show, id: @salesman
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salesman
    assert_response :success
  end

  test "should update salesman" do
    patch :update, id: @salesman, salesman: { name: @salesman.name, phone: @salesman.phone, supplier_id: @salesman.supplier_id }
    assert_redirected_to salesman_path(assigns(:salesman))
  end

  test "should destroy salesman" do
    assert_difference('Salesman.count', -1) do
      delete :destroy, id: @salesman
    end

    assert_redirected_to salesmen_path
  end
end

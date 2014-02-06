require 'test_helper'

class ClientPhonesControllerTest < ActionController::TestCase
  setup do
    @client_phone = client_phones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_phones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_phone" do
    assert_difference('ClientPhone.count') do
      post :create, client_phone: { client_id: @client_phone.client_id, phone: @client_phone.phone }
    end

    assert_redirected_to client_phone_path(assigns(:client_phone))
  end

  test "should show client_phone" do
    get :show, id: @client_phone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_phone
    assert_response :success
  end

  test "should update client_phone" do
    patch :update, id: @client_phone, client_phone: { client_id: @client_phone.client_id, phone: @client_phone.phone }
    assert_redirected_to client_phone_path(assigns(:client_phone))
  end

  test "should destroy client_phone" do
    assert_difference('ClientPhone.count', -1) do
      delete :destroy, id: @client_phone
    end

    assert_redirected_to client_phones_path
  end
end

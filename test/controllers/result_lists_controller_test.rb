require 'test_helper'

class ResultListsControllerTest < ActionController::TestCase
  setup do
    @result_list = result_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:result_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create result_list" do
    assert_difference('ResultList.count') do
      post :create, result_list: { order: @result_list.order, sessionid: @result_list.sessionid, type: @result_list.type, value: @result_list.value }
    end

    assert_redirected_to result_list_path(assigns(:result_list))
  end

  test "should show result_list" do
    get :show, id: @result_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @result_list
    assert_response :success
  end

  test "should update result_list" do
    patch :update, id: @result_list, result_list: { order: @result_list.order, sessionid: @result_list.sessionid, type: @result_list.type, value: @result_list.value }
    assert_redirected_to result_list_path(assigns(:result_list))
  end

  test "should destroy result_list" do
    assert_difference('ResultList.count', -1) do
      delete :destroy, id: @result_list
    end

    assert_redirected_to result_lists_path
  end
end

require 'test_helper'

class StopWatchesControllerTest < ActionController::TestCase
  setup do
    @stop_watch = stop_watches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stop_watches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stop_watch" do
    assert_difference('StopWatch.count') do
      post :create, stop_watch: { start: @stop_watch.start, stop: @stop_watch.stop }
    end

    assert_redirected_to stop_watch_path(assigns(:stop_watch))
  end

  test "should show stop_watch" do
    get :show, id: @stop_watch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stop_watch
    assert_response :success
  end

  test "should update stop_watch" do
    patch :update, id: @stop_watch, stop_watch: { start: @stop_watch.start, stop: @stop_watch.stop }
    assert_redirected_to stop_watch_path(assigns(:stop_watch))
  end

  test "should destroy stop_watch" do
    assert_difference('StopWatch.count', -1) do
      delete :destroy, id: @stop_watch
    end

    assert_redirected_to stop_watches_path
  end
end

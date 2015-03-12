require 'test_helper'

class VideoFeaturesControllerTest < ActionController::TestCase
  setup do
    @video_feature = video_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:video_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create video_feature" do
    assert_difference('VideoFeature.count') do
      post :create, video_feature: { type_qwatch: @video_feature.type_qwatch, type_series: @video_feature.type_series, video_id: @video_feature.video_id }
    end

    assert_redirected_to video_feature_path(assigns(:video_feature))
  end

  test "should show video_feature" do
    get :show, id: @video_feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @video_feature
    assert_response :success
  end

  test "should update video_feature" do
    patch :update, id: @video_feature, video_feature: { type_qwatch: @video_feature.type_qwatch, type_series: @video_feature.type_series, video_id: @video_feature.video_id }
    assert_redirected_to video_feature_path(assigns(:video_feature))
  end

  test "should destroy video_feature" do
    assert_difference('VideoFeature.count', -1) do
      delete :destroy, id: @video_feature
    end

    assert_redirected_to video_features_path
  end
end

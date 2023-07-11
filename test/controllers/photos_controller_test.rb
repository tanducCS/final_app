require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get photo" do
    get photos_photo_url
    assert_response :success
  end
end

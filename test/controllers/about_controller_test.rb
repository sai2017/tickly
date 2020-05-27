require 'test_helper'

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get about_index_url
    assert_response :success
  end

  test "should get message_from_tickly" do
    get about_message_from_tickly_url
    assert_response :success
  end

  test "should get usage" do
    get about_usage_url
    assert_response :success
  end

end

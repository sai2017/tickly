require 'test_helper'

class ToppageControllerTest < ActionDispatch::IntegrationTest
  test "should get terms" do
    get toppage_terms_url
    assert_response :success
  end

  test "should get privacy" do
    get toppage_privacy_url
    assert_response :success
  end

end

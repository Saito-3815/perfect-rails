require 'test_helper'

class StatusControllerTest < ActionDispatch::IntegrationTest
  test "GET /status" do
    get "/status"
    assert_response :success
    assert_equal({ status: "ok" }.to_json, @response.body)
    # 機能テストでは@responseを使ってレスポンスの情報を取得できる
    # @requestを使ってリクエストの情報を取得できる
    assert_equal("application/json", @response.media_type)
  end
end

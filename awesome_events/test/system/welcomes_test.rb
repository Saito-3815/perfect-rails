require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  test "/ ページを表示" do
    visit root_url # visitでGETリクエストを送信

    assert_selector "h1", text: "イベント一覧"
  end
end

require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "/events/:id ページを表示" do
    event = FactoryBot.create(:event)
    visit event_url(event)
    assert_selector "h1", text: event.name
  end

  test "/events/new ページを表示" do
    sign_in_as(FactoryBot.create(:user))

    visit new_event_url
    assert_selector "h1", text: "イベント作成"
  end

  test "/events/new ページでフォームを記入して登録" do
    sign_in_as(FactoryBot.create(:user))

    visit new_event_url
    assert_selector "h1", text: "イベント作成"

    fill_in "名前", with: "TokyoRubyKaigi"
    fill_in "場所", with: "東京"
    fill_in "内容", with: "tokyu.rbによる地域Ruby会議"

    start_at = Time.current
    end_at = start_at + 3.hours

    start_at_field = "event_start_at"
    select start_at.strftime("%Y"), from: "#{start_at_field}_1i" # 年
    select I18n.l(start_at, format: '%B'), from: "#{start_at_field}_2i" # 月
    select start_at.strftime("%-d"), from: "#{start_at_field}_3i" # 日
    select start_at.strftime("%H"), from: "#{start_at_field}_4i" # 時
    select start_at.strftime("%M"), from: "#{start_at_field}_5i" # 分

    end_at_field = "event_end_at"
    select end_at.strftime("%Y"), from: "#{end_at_field}_1i" # 年
    select I18n.l(end_at, format: '%B'), from: "#{end_at_field}_2i" # 月
    select end_at.strftime("%-d"), from: "#{end_at_field}_3i" # 日
    select end_at.strftime("%H"), from: "#{end_at_field}_4i" # 時
    select end_at.strftime("%M"), from: "#{end_at_field}_5i" # 分

    click_on "登録する"
    assert_text "作成しました"
  end

  test "/events/:id ページを表示して削除ボタンを押す" do
    sign_in_as(FactoryBot.create(:user))
    event = FactoryBot.create(:event, owner: current_user)
    visit event_url(event)
    # ブロック内の処理を実行する前後で引数の値が変わることを確認
    assert_difference('Event.count', -1) do
      accept_confirm do # 渡されたブロック中で表示されたダイアログを確認してOKを押す
        click_on "イベントを削除する"
      end
      assert_selector "div.alert", text: "削除しました"
    end
  end

  test "/ ページを表示して、未来のイベントは表示、過去のイベントは非表示であること" do
    future_event = FactoryBot.create(:event, start_at: Time.zone.now + 3.day)
    past_event = FactoryBot.create(:event, start_at: Time.zone.now + 1.day)

    travel_to Time.zone.now + 2.day do # 引数で指定した日時に移動する
      visit root_url
      assert_selector "h5", text: future_event.name
      assert_no_selector "h5", text: past_event.name
    end
  end
end

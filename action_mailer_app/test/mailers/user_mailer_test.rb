require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome" do
    email = UserMailer.with(to: "igarashi@example.com", name: "igaiga").welcome
    # メールが送信キューに追加されるかどうかをテスト
    assert_emails(1) { email.deliver_now }
    # 送信されたメールを確認するテスト
    assert_equal ["sai.engineer3815@gmail.com"], email.from
    assert_equal ["igarashi@example.com"], email.to
    assert_equal "登録完了", email.subject
    assert_includes email.text_part.decoded, "igaiga"
    assert_includes email.html_part.decoded, "igaiga"
  end
end

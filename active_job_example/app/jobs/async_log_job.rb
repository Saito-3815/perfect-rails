class AsyncLogJob < ApplicationJob
  # queue_as :default
  # ジョブの内容によってキューを分ける例
  queue_as do
    case self.arguments.first[:message]
    when "to async_log"
      :async_log
    else
      :default
  end

  def perform(message: "hello") # message引数を追加
    AsyncLog.create!(message: message) # DBに保存
  end

  # ジョブのリトライ(wait: 待ち時間, attempts: リトライ回数)
  # retry_on StandardError, wait: 5.seconds, attempts: 3
  # 複数の例外を指定することも可能
  # retry_on ZeroDivisionError, TypeError, wait: 10.seconds, attempts: 3

  # ジョブの破棄
  # discard_on StandardError
  # ブロックを使うことも可能
  discard on StandardError do |job, error|
    SomeNotifier.push_error(error) # 通知を送る
  end
end

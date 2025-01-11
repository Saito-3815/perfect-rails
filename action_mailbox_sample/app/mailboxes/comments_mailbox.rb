class CommentsMailbox < ApplicationMailbox
  before_processing :validate_request

  def process
    board.comments.create!(body: mail.decoded, creator: commenter)
  end

  # リクエストのバリデーション
  def validate_request
    return if commenter && board

    # 引数で受け取ったActionMailerオブジェクトに対してdeliver_laterメソッドを実行し、かつInboundMailの状態をbouncedに変更
    # bounced状態の時はprocessメソッドが実行されない
    bounce_with CommentMailer.invalid_request(
      inbound_email, commenter: commenter, board: board
    )
  end

  # コメント投稿者となるオブジェクトを取得
  def commenter
    return @commenter if defined?(@commenter)
    @commenter = User.find_by(email: mail.from)
  end

  # 書き込み先Boardオブジェクトを取得
  def board
    return @board if defined?(@board)
    @board = Board.find_by(id: mail.to.split('-')[0])
  end
end

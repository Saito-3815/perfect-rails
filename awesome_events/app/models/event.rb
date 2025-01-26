class Event < ApplicationRecord
  # searchkickメソッドで専用のメソッドをモデルへ追加
  # language: "japanese"を指定することで検索に日本語検索エンジンkuromojiを使用
  searchkick language: "japanese"
  # has_one_attachedにdependent: :falseを指定することで、イベントが削除時にActive::Storage::Attachment(中間モデル)のみ削除
  # Active::Storage::Blob(画像ファイル)は削除されないので再びアタッチすることで復元できる
  has_one_attached :image, dependent: :false
  has_many :tickets, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  validates :image,
    content_type: [:png, :jpg, :jpeg],
    size: { less_than_or_equal_to: 10.megabytes },
    dimension: { width: { max: 2000 }, height: { max: 2000 } }
  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_should_be_before_end_at

  attr_accessor :remove_image

  before_save :remove_image_if_user_accept

  def created_by?(user)
    return false unless user

    owner_id == user.id
  end

  # このメソッドの戻り値がインデックスに追加される
  # 検索フォームで入力するキーワードにマッチさせる情報とイベント開始時間を登録
  def search_data
    {
      name: name,
      place: place,
      content: content,
      owner_name: owner&.name,
      start_at: start_at
    }
  end

  private

  def start_at_should_be_before_end_at
    return unless start_at && end_at

    errors.add(:start_at, 'は終了日時よりも前に設定してください') if start_at >= end_at
  end

  def remove_image_if_user_accept
    # ActiveRecord::Type::Boolean.new.castは、文字列を真偽値に変換する
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end
end

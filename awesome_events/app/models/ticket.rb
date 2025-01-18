class Ticket < ApplicationRecord
  # 退会した場合はuser_idがnilになるため、optional: trueを指定
  # 関連先のレコードがなくてもバリデーションエラーとならない
  belongs_to :user, optional: true
  belongs_to :event

  validates :comment, length: { maximum: 30 }, allow_blank: true
end

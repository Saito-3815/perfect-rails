class Comment < ApplicationRecord
  belongs_to :creator, class_name: 'User' # creatorというカスタム名を持つUserモデルを参照する外部キー
  belongs_to :board
end

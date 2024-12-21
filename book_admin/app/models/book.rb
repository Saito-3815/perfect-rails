class Book < ApplicationRecord
  scope :costly, -> { where("price > ?", 3000) }
  # % はワイルドカードで、その位置に任意の文字列が入ることを表す
  scope :written_about, ->(theme) { where("name like?", "%#{theme}%")}
  scope :find_price, ->(price) { find_by(price: price) }

  belongs_to :publisher
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate do |book|
    if book.name.include?("exercise")
      book.errors[:name] << "I don't like exercise."
    end
  end
  before_validation do
    # gsubメソッドは、第一引数に指定した正規表現にマッチした部分を、第二引数の文字列で置換するメソッド
    self.name = self.name.gsub(/Cat/) do |matched|
      "lovely #{matched}"
    end
  end
  after_destroy do
    Rails.logger.info "Book is deleted: #{self.attributes}"
  end
end

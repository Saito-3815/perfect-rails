class Book < ApplicationRecord
  # enum型は数値のカラムに対してプログラム上の別名を定義できる(DB上の保存値は数値となる)
  # book.now_on_sale?で状態を確認できる
  # book.reservation!で状態を変更できる
  # クラスメソッドBook.sales_statusesで状態の一覧を取得できる
  # Book.now_on_saleで状態を指定して検索できるスコープも定義される。Book.not_now_on_saleで否定形も使える
  enum sales_status: {
    reservation: 0, # 予約受付
    now_on_sale: 1, # 発売中
    end_of_print: 2 # 販売終了
}

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
  after_destroy :if => :high_price? do # コールバックの条件指定
    Rails.logger.warn "Book with high price is deleted: #{self.attributes}"
    Rails.logger.warn "Please check!!"
  end

  def high_price?
    price >= 5000
  end
end

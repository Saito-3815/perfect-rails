# 検索フォームのモデルクラス
class EventSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string
  attribute :page, :integer

  # searchkickで検索するためのメソッド
  def search
    Event.search(
      keyword_for_search,
      where: { start_at: { gt: start_at } },
      page: page,
      per_page: 10
    )
  end

  def start_at
    @start_at || Time.current
  end

  def start_at=(new_start_at)
    @start_at = new_start_at.in_time_zone
  end

  private

  # 何も入力がない場合は全検索で全ての検索結果を表示する
  def keyword_for_search
    keyword.presence || "*"
  end
end

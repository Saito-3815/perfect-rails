class SubBase < ApplicationRecord
  # このクラスを抽象クラスとして定義する
  # 抽象クラスとは、直接インスタンス化されずデータベースのテーブルを持たないクラスのこと
  self.abstract_class = true
  establish_connection :sub
end

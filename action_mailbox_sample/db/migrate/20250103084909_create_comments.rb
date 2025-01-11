class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :creator, null: false, foreign_key: { to_table: :users } # usersテーブルを参照する外部キー
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end

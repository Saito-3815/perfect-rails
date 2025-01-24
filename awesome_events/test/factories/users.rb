FactoryBot.define do
  factory :user, aliases: [:owner] do
    provider { "github" }
    # sequenceメソッドで連番を生成
    sequence(:uid) { |i| "uid_#{i}" }
    sequence(:name) { |i| "name_#{i}" }
    sequence(:image_url) { |i| "http://example.com/image_#{i}.jpg" }
  end
end

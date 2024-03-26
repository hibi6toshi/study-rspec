FactoryBot.define do
  # Bot を使う際はユーザーファクトリに対して owner という名前で参照さ れる場合があると伝えなくてはいけません。
  factory :user, aliases: [:owner] do
    first_name { "Aaron" }
    last_name  { "Sumner" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "dottle-nouveau-pavilion-tights-furze" }
  end
end

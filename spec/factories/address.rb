FactoryBot.define do

  factory :address do
    user_id            {"1"}
    postal_code        {"1234567"}
    prefectures        {"東京都"}
    municipalities     {"渋谷区"}
    address            {"神南１丁目１−１"}
  end

end
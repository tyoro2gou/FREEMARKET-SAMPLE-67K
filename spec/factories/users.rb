FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"山田"}
    last_name             {"綾"}
    family_name_kana      {"ヤマダ"}
    last_name_kana        {"アヤ"}
    birthday_info         {"19950401"}
  end

end
FactoryBot.define do

  factory :item do
    name              {"コート"}
    description       {"新品未使用です。"}
    status_id         {"2"}
    postage_id        {"2"}
    region_id         {"2"}
    shipping_date_id  {"2"}
    price             {"5000"}
    category_id       {"2"}
    saler_id          {"1"}
    
    
  end
end
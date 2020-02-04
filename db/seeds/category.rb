#---
parent = Category.create(name: '---')


#レディース
lady_child_array = ['トップス','ジャケット/アウター','パンツ','スカート','ワンピース','その他']
parent = Category.create(name: 'レディース')
lady_child_array.each_with_index do |child, i|
  child = parent.children.create(name: child)
end


#メンズ
mens_child_array = ['トップス','ジャケット/アウター','パンツ','靴','バッグ','その他']
parent = Category.create(name: 'メンズ')
mens_child_array.each.each_with_index do |child, i|
  child = parent.children.create(name: child)
end


#ベビー・キッズ
babykids_child_array = ['ベビー服','キッズ服','バッグ','おむつ','おもちゃ','その他']
parent = Category.create(name: 'ベビー・キッズ')
babykids_child_array.each.each_with_index do |child, i|
  child = parent.children.create(name: child)
end


#その他
others_child_array = ['ペット用品','食品','飲料/酒','日用品','文房具/事務用品','その他']
parent = Category.create(name: 'その他')
others_child_array.each.each_with_index do |child, i|
  child = parent.children.create(name: child)
end
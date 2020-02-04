# seedデータを分割して実行できるようにする
# https://qiita.com/masaki7555/items/d65f56958020cbca5ee0
# http://yu0105teshi.hateblo.jp/entry/2016/08/03/180603
Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
  desc "Load the seed data from db/seeds/#{File.basename(file)}."
  task "db:seed:#{File.basename(file).gsub(/\..+$/, '')}" => :environment do
    load(file)
  end
end
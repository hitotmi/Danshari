# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tags = Tag.create([
  { name: '価値判断' },
  { name: 'リメイクアイデア' },
  { name: '収納方法' },
  { name: '後押しがほしい' },
  { name: '思い出の品' },
  { name: '古い物' },
  { name: '高価な物' },
  { name: '未使用品' },
  { name: '物品への愛着' },
  { name: '決断困難' },
  { name: '優柔不断' },
  { name: '衝動買い' },
  { name: '買い物中毒' },
  { name: '捨てることへの恐怖・不安' },
  { name: 'いつか使うかも' },
  { name: '断捨離の挑戦' },
  { name: 'ミニマリストへの道' },
])

Admin.create!(
  email: "admin@admin.com",
  password: "666666"
)

User.create!(
  [
    {email: 'sakamoto@sakamoto.com', name: '坂本', password: '666666', is_deleted: false},
    {email: 'okamoto@okamoto.com', name: '岡本', password: '666666', is_deleted: false},
    {email: 'nakata@nakata.com', name: '中田', password: '666666', is_deleted: false}
  ]
)

CounselingPost.create!(
  [
    {
      title: '漫画がいっぱいで本棚に入らなくなりました。こういう時どうしていますか？',
      content: "本棚が他の本でいっぱいでこれ以上入りません。部屋のスペース的にも正直捨てないといけないかなと考えています。\nですが、お気に入りな漫画なこともあり捨てることに抵抗があります。\n皆さんどうしてますか？",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"),
      status: :answer_reception,
      usage_frequency: :once_to_1_year,
      star: 4,
      tag_ids: tags.select { |tag| ["収納方法", "物品への愛着", "決断困難"].include?(tag.name) }.map(&:id),
      user_id: 2
    },
    {
      title: '小学生の時に集めたハッピーセット。掃除をしている最中で捨てるか悩んでます。',
      content: "ハッピーセットの大量保有により、限られたスペースが圧迫されています。\n思い出が詰まったこれらを捨てるのは躊躇しますが、スペースの制約も問題です。\nどうすれば良いか困っています。",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"),
      status: :answer_reception,
      usage_frequency: :unused,
      star: 3,
      tag_ids: tags.select { |tag| ["未使用品", "思い出の品", "決断困難"].include?(tag.name) }.map(&:id),
      user_id: 3
    },
    {
      title: 'UFOキャッチャーでとれたぬいぐるみ。捨てたいけど捨てられない事態が発生しています。',
      content: "取れたのは良かったのですが、部屋の雰囲気と違い置く場所に困っています。\n捨てようとも思いましたがぬいぐるみを一般ごみで捨ててしまうとよくないようなことを聞いたことがあり、捨てるか捨てないかで迷っています。",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"),
      status: :answer_reception,
      usage_frequency: :unused,
      tag_ids: tags.select { |tag| ["捨てることへの恐怖・不安"].include?(tag.name) }.map(&:id),
      user_id: 1
    },
    {
      title: '学生時代の教科書が捨てられずに困っています。',
      content: "学生時代に使用した教科書がまだ手元にあります。\n内容を再度見返す可能性もあると思い、捨てるのに躊躇しているのですが、実際見返したことはありません。\n皆さんはどうしていますか？",
      status: :answer_reception,
      usage_frequency: :unused,
      tag_ids: tags.select { |tag| ["決断困難","未使用品", "思い出の品"].include?(tag.name) }.map(&:id),
      user_id: 1
    },
    {
      title: '同じような服で溢れていて、あまり着ないけどもったいなくて捨てれません。',
      content: "ほとんど着用もしていませんが、捨てるのはもったいないと感じています。\n新品同様の状態であるからこそ、捨てることはもったいなく感じてしまいます。\nいつか必ず着るだろうという期待もあって、余計に手放せません。
                \nしかし、クローゼットの収納スペースも限られているので捨てたほうがいいか、捨てずに置いておくか迷っています。",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post.jpg"), filename:"sample-post.jpg"),
      status: :answer_reception,
      usage_frequency: :unused,
      star: 1,
      tag_ids: tags.select { |tag| ["決断困難","未使用品", "優柔不断"].include?(tag.name) }.map(&:id),
      user_id: 2
    },
  ]
)




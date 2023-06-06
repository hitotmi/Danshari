# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "arupusu@example.com",
  password: "arupusu"
)

Tag.create([
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
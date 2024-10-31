# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザーの作成
user1 = User.create!(email: 'user1@example.com', password: 'password', name: 'User One')
user2 = User.create!(email: 'user2@example.com', password: 'password', name: 'User Two')


# 施設の作成
rooms = [
  { name: '東京ホテル', description: '東京の中心にあるホテル', price_per_day: 8000, address: '東京都新宿区' },
  { name: '大阪リゾート', description: '大阪のリゾートホテル', price_per_day: 7000, address: '大阪府大阪市' },
  { name: '京都イン', description: '京都の観光地近くのホテル', price_per_day: 6000, address: '京都府京都市' },
  { name: '札幌ステイ', description: '札幌のビジネスホテル', price_per_day: 5000, address: '北海道札幌市' }
]

rooms.each do |room_data|
  Room.create!(room_data.merge(user: user1))
end


# 予約の作成
room1 = Room.first
room2 = Room.second

reservations = [
  { check_in: Date.today + 1, check_out: Date.today + 3, guests: 2, user: user1, room: room1 },
  { check_in: Date.today + 5, check_out: Date.today + 8, guests: 3, user: user1, room: room2 },
  { check_in: Date.today + 2, check_out: Date.today + 4, guests: 1, user: user2, room: room1 }
]

reservations.each do |reservation_data|
  Reservation.create!(reservation_data)
end

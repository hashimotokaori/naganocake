# Admin.create!(
#   email: "a@a",
#   password: "aaaaaaa"
# )

# Genre.create!(
#     name: "ケーキ",
#   )
  
  item=Item.create!(
    genre_id: 1,
    name: "いちごのショートケーキ（ホール）",
    introduction: "栃⽊県産のとちおとめを贅沢に使⽤しています。",
    price: 2750,
    is_active: [['販売中', true], ['販売停止', false]]
  )
  item.image.attach(io: File.open(Rails.root.join('app/assets/images/cake6.jpg')), filename: 'cake.jpg')
  

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

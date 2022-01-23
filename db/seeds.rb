shop = Shop.create!(name: "Kripto Tools")

sales_point = SalesPoint.create!(
  address_line1: "12345 Venice Street",
  address_line2: "Arkansas, Fayetteville, 12345",
  shop: shop
)

alphabet = %i[A B C D E F G H I J K L M N O N P Q R S T U V W X Y Z]

40.times do 
  s = alphabet.shuffle.sample(5).join

  product = Product.create!(
    name: "Crypto Wallet #{s}", 
    price: 400,
    sales_point: sales_point
  )
end

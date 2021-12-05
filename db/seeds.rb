shop = Shop.create!(name: "Kripto Tools")

sales_point = SalesPoint.create!(
  address_line1: "12345 Venice Street",
  address_line2: "Arkansas, Fayetteville, 12345",
  shop: shop
)

product = Product.create!(
  name: "Crypto Wallet ABC", 
  price: 400,
  sales_point: sales_point
)

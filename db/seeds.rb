puts "cleaning up database"
Location.destroy_all
puts "Database is clean"

puts "Creating locations"

  Location.create!(
  availability: true,
  location_address: "Carrer de Mallorca, 401, Barcelona",
  price: Faker::Number.between(from: 1, to: 10),
  name: Faker::FunnyName.name,
  description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
  property_type: 'garage'
  )

  Location.create!(
  availability: true,
  location_address: "Carrer de l'Hospital, 114, Barcelona",
  price: Faker::Number.between(from: 1, to: 10),
  name: Faker::FunnyName.name,
  description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
  property_type: 'garage'
  )

  Location.create!(
  availability: true,
  location_address: "Ronda de Sant Pere, 35, Barcelona",
  price: Faker::Number.between(from: 1, to: 10),
  name: Faker::FunnyName.name,
  description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
  property_type: 'garage'
  )

  Location.create!(
  availability: true,
  location_address:"Rambla del Raval, 26, Barcelona",
  price: Faker::Number.between(from: 1, to: 10),
  name: Faker::FunnyName.name,
  description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
  property_type: 'garage'
  )

puts "Locations created"

puts "Done"

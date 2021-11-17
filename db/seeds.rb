require "open-uri"

puts "cleaning up database"
Location.destroy_all
puts "Database is clean"

puts "Creating locations"

def random_address
  ["Passeig de Gracia, Barcelona", "Passeig de Sant Joan, Barcelona", "Passeig del Born, Barcelona",
   "Carrer del Consell de Cent, Barcelona", "Carrer dels Tallers, Barcelona", "Carrer del Blai, Barcelona",
   "Rua de Santa Catarina, Porto", "Rua de Boavista, Porto", "Rua do Campo Alegre, Porto",
   "Rua da Graciosa, Porto", "Rua da Constituicao, Porto", "Rua do Melo, Porto", "Rua de Sao Paulo, Porto",
   "Rua Antonio Nobre, Porto", "Rua Joao Grave, Porto", "Avenida da Franca, Porto", "Calle Leon XIII, Sevilla",
   "Calle Sierpes, Sevilla", "Calle Betis, Sevilla", "Avenida de la Paz, Sevilla", "Avenida de la Buhaira, Sevilla",
   "Avenida de Hytasa, Sevilla", "Calle Alonso Cano, Sevilla", "Calle Antonio Delgado, Sevilla"].sample
end

def random_property
  %w[garage spare-room basement container shed attic warehouse office].sample
end


4.times do
  User.create!(
    email: Faker::Internet.email,
    password: "a766868sf",
    name:"adfgf",
    phone_number: "adfgf",
    seller_type: "adfgf"
  )
end

10.times do

  file = URI.open('https://source.unsplash.com/1600x900/?storage')


  location = Location.new(
    availability: true,
    location_address: random_address,
    price: Faker::Number.between(from: 1, to: 10),
    name: "A #{Faker::Adjective.positive} storage space by #{Faker::FunnyName.name}",
    description: "#{Faker::Company.catch_phrase}: #{Faker::Company.bs}",
    property_type: random_property,
    user_id: User.all.sample.id,
  )
  location.name = "A #{Faker::Adjective.positive} #{location.property_type} by #{Faker::FunnyName.name}"
  location.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  location.save!
  p "Created #{location.name}"
end

#   location = Location.new(
#   availability: true,
#   location_address: "Carrer de Mallorca, 401, Barcelona",
#   price: Faker::Number.between(from: 1, to: 10),
#   name: Faker::FunnyName.name,
#   description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
#   property_type: 'garage'
#   )
#   location.user_id = user.id
#   location.save
# end
#   Location.create!(
#   availability: true,
#   location_address: "Carrer de l'Hospital, 114, Barcelona",
#   price: Faker::Number.between(from: 1, to: 10),
#   name: Faker::FunnyName.name,
#   description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
#   property_type: 'garage'
#   )

#   Location.create!(
#   availability: true,
#   location_address: "Ronda de Sant Pere, 35, Barcelona",
#   price: Faker::Number.between(from: 1, to: 10),
#   name: Faker::FunnyName.name,
#   description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
#   property_type: 'garage'
#   )

#   Location.create!(
#   availability: true,
#   location_address:"Rambla del Raval, 26, Barcelona",
#   price: Faker::Number.between(from: 1, to: 10),
#   name: Faker::FunnyName.name,
#   description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
#   property_type: 'garage'
#   )

puts "Locations created"

puts "Done"

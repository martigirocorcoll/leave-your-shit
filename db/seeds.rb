require "open-uri"

puts "cleaning up database"
Location.destroy_all
User.destroy_all
puts "Database is clean"

puts "Creating locations"

def random_address
  # Samples a random, real address from Barcelona, Porto or Sevilla
  ["Passeig de Gracia, Barcelona", "Passeig de Sant Joan, Barcelona", "Passeig del Born, Barcelona",
   "Carrer del Consell de Cent, Barcelona", "Carrer dels Tallers, Barcelona", "Carrer del Blai, Barcelona",
   "Rua de Santa Catarina, Porto", "Rua de Boavista, Porto", "Rua do Campo Alegre, Porto",
   "Rua da Graciosa, Porto, Portugal", "Rua da Constituicao, Porto, Portugal", "Rua do Melo, Porto, Portugal", "Rua de Sao Paulo, Porto, Portugal",
   "Rua Antonio Nobre, Porto, Portugal", "Rua Joao Grave, Porto, Portugal", "Avenida da Franca, Porto, Portugal", "Calle Leon XIII, Sevilla",
   "Calle Sierpes, Sevilla", "Calle Betis, Sevilla", "Avenida de la Paz, Sevilla", "Avenida de la Buhaira, Sevilla",
   "Avenida de Hytasa, Sevilla", "Calle Alonso Cano, Sevilla", "Calle Antonio Delgado, Sevilla"].sample
end

def random_photo(keyword)
  hash = {
    "garage" => %w[https://images.unsplash.com/photo-1547165908-2a556c7d267a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1522758971460-1d21eed7dc1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80
    https://images.unsplash.com/photo-1594818020972-e96e722493f7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1624910985761-8be5af65b457?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1614972625561-bc56585aba6b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1562099785-f944f2a9a97e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1613989404255-a5773098f5d0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80],
    "spare room" => %w[https://images.unsplash.com/flagged/photo-1556438758-872c68902f60?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=874&q=80
    https://images.unsplash.com/photo-1444419988131-046ed4e5ffd6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1630699144919-681cf308ae82?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1630699376059-b781970715b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1597293544475-16730f31a638?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=442&q=80
    https://images.unsplash.com/photo-1529622368377-4090e6daae59?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=808&q=80
    https://images.unsplash.com/photo-1610806712920-b178c8c9f79d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=869&q=80
    https://images.unsplash.com/photo-1604307612848-fcb357b1360c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=780&q=80],
    "basement" => %w[https://images.unsplash.com/photo-1522758971460-1d21eed7dc1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80
    https://images.unsplash.com/photo-1529622368377-4090e6daae59?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=808&q=80
    https://images.unsplash.com/photo-1604997266148-a2640dce04c6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1623955277601-2aa7bb3fb240?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1443884590026-2e4d21aee71c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=843&q=80
    https://images.unsplash.com/photo-1584521104370-bdc01d02d3d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1610806712920-b178c8c9f79d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=869&q=80],
    "container" => %w[https://images.unsplash.com/photo-1533643643812-4143839ba096?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=465&q=80
    https://images.unsplash.com/photo-1605732563938-8f8d4e7ad651?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80
    https://images.unsplash.com/photo-1610957601813-3b93a900a05b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1606964212858-c215029db704?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    ],
    "shed" => %w[https://images.unsplash.com/photo-1589574097341-acd57bd79fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80
    https://images.unsplash.com/photo-1522852179007-db016382486c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1557007719-945cadcf2e33?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1496249872230-8bd9cc160389?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1512941158376-70562fd07922?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=946&q=80
    https://images.unsplash.com/photo-1554863798-1763f0e107e1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80],
    "attic" => %w[https://images.unsplash.com/photo-1522758971460-1d21eed7dc1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80
    https://images.unsplash.com/photo-1588066696414-113c404edfdf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80
    https://images.unsplash.com/photo-1571568154091-c6105f85ecc6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=868&q=80
    https://images.unsplash.com/photo-1613643044194-5f11845ab16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1609063689795-4064170a211b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=774&q=80
    https://images.unsplash.com/photo-1591825729269-caeb344f6df2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1443884590026-2e4d21aee71c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=843&q=80],
    "warehouse" => %w[https://images.unsplash.com/photo-1522758971460-1d21eed7dc1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80
    https://images.unsplash.com/photo-1589574097341-acd57bd79fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80
    https://images.unsplash.com/photo-1522852179007-db016382486c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1557007719-945cadcf2e33?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1496249872230-8bd9cc160389?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1512941158376-70562fd07922?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=946&q=80
    https://images.unsplash.com/photo-1554863798-1763f0e107e1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80],
    "office" => %w[https://images.unsplash.com/photo-1613643044194-5f11845ab16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80
    https://images.unsplash.com/photo-1497366216548-37526070297c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=869&q=80
    https://images.unsplash.com/photo-1596079890744-c1a0462d0975?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80
    https://images.unsplash.com/photo-1535957998253-26ae1ef29506?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=436&q=80
    https://images.unsplash.com/photo-1497366811353-6870744d04b2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=869&q=80
    https://images.unsplash.com/photo-1604328698692-f76ea9498e76?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80]
  }
  hash[keyword].sample
end

def random_property
  # Samples a random property type
  %w[garage spare-room basement container shed attic warehouse office].sample
end

def concordance(adjective)
  # Ensures there is concordance in the name of the location
  if %w[a e i o u].include?(adjective[0])
    "An #{adjective}"
  else
    "A #{adjective}"
  end
end

4.times do
  User.create!(
    email: Faker::Internet.email,
    password: "123456",
    name: Faker::FunnyName.name,
    phone_number: Faker::PhoneNumber.phone_number,
    seller_type: ["professional", "personal"].sample
  )
end

5.times do
  adjective = Faker::Adjective.positive
  adjective2 = Faker::Adjective.positive
  location = Location.new(
    availability: true,
    location_address: random_address,
    price: Faker::Number.between(from: 1, to: 10),
    description: "#{Faker::Company.catch_phrase}: #{Faker::Company.bs}",
    property_type: random_property,
    user_id: User.all.sample.id
  )
  keyword_property = location.property_type.gsub("-", " ")
  file = URI.open(random_photo(keyword_property))
  # file = URI.open("https://source.unsplash.com/1600x900/?storage,#{keyword_property}")
  location.name = "#{concordance(adjective)} and #{adjective2} #{location.property_type} by #{location.user.name}"
  location.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  location.save!
  p "Created #{location.name}"
end

location1 = Location.new(
  availability: true,
  location_address: random_address,
  price: Faker::Number.between(from: 1, to: 10),
  description: "A very nice place that I have to spare. It was left behind by my grandfather. He mysteriously disappeared, and this is the last place he was seen going to.",
  property_type: "basement",
  user_id: User.all.sample.id
)
file = URI.open(random_photo("basement"))
# file = URI.open("https://source.unsplash.com/1600x900/?storage,#{keyword_property}")
location1.name = "A wonderful and mysterious basement by #{location1.user.name}"
location1.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
location1.save!
p "Created #{location1.name}"

10.times do
  adjective = Faker::Adjective.positive
  adjective2 = Faker::Adjective.positive
  location = Location.new(
    availability: true,
    location_address: random_address,
    price: Faker::Number.between(from: 1, to: 10),
    description: "#{Faker::Company.catch_phrase}: #{Faker::Company.bs}",
    property_type: random_property,
    user_id: User.all.sample.id
  )
  keyword_property = location.property_type.gsub("-", " ")
  file = URI.open(random_photo(keyword_property))
  # file = URI.open("https://source.unsplash.com/1600x900/?storage,#{keyword_property}")
  location.name = "#{concordance(adjective)} and #{adjective2} #{location.property_type} by #{location.user.name}"
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

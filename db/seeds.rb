# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Service.create(category: 'Tugs')
Service.create(category: 'Pilots')
Service.create(category: 'Launch Services')
Service.create(category: 'Fresh Water')
Service.create(category: 'Garbage Disposal')
Service.create(category: 'Polution Net')

handymax = VesselType.create(category: 'Handymax')
VesselType.create(category: 'Panamax')

greece = Country.create(iso: 'GR', name: 'GREECE', printableName: 'Greece', iso3: 'GRC', numCode: 300)
Country.create(iso: 'FR', name: 'FRANCE', printableName: 'France', iso3: 'FRA', numCode: 250)
Country.create(iso: 'IT', name: 'ITALY', printableName: 'Italy', iso3: 'ITA', numCode: 380)
Country.create(iso: 'IL', name: 'ISRAEL', printableName: 'Israel', iso3: 'ISR', numCode: 376)

Port.create(name: 'Port of Nisos Naxos', country_id: greece.id, lat:'37.1', lng:'25.366667')
Port.create(name: 'Port of Nauplia', country_id: greece.id, lat:'37.566667', lng:'22.8')
Port.create(name: 'Port of Piraeus', country_id: greece.id, lat:'37.933333', lng:'23.633333')

c1 = ShippingCompany.create(name: "Kampanis", country_id: greece.id, address: "Fifth Avenue 23", telephone: "+30 2105544345", email: "info@kampanis.gr")
a1 = Agent.create(name: "BestAgents", country_id: greece.id, address: "Sporadon 23", telephone: "+30 2104543245", email: "info@bestagents.gr")

f1 = Fleet.create(name: "MyJennys", shipping_company_id: c1.id)
Ship.create(name: "Jenny", fleet_id: f1.id, vessel_type_id: handymax.id)

#Operation.create(agent_id: 1, port_id: 1)
Operation.create(agent_id: 1, port_id: 2)
Operation.create(agent_id: 1, port_id: 3)

admin = User.create(name: 'Admin', email: 'admin@example.com', password:'foobar', password_confirmation:'foobar', admin: true)

SCUser.create(name: 'Mike', email: 'mike@kampanis.gr', password:'foobar', password_confirmation:'foobar', shipping_company_id: c1.id)
AUser.create(name: 'Scottie', email: 'scottie@bestagents.gr', password:'foobar', password_confirmation:'foobar', agent_id: a1.id)

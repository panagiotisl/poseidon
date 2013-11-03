# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



#other = Category.create(name:'Other')
#shipping = Category.create(name:'Shipping')

#affiliation = Affiliation.create(name: 'Other', category_id: other.id)
#affiliation = Affiliation.first
#Affiliation.create(name: 'Kampanis', category_id: shipping.id)

greece = Country.create(iso: 'GR', name: 'GREECE', printableName: 'Greece', iso3: 'GRC', numCode: 300)
Country.create(iso: 'FR', name: 'FRANCE', printableName: 'France', iso3: 'FRA', numCode: 250)
Country.create(iso: 'IT', name: 'ITALY', printableName: 'Italy', iso3: 'ITA', numCode: 380)
Country.create(iso: 'IL', name: 'ISRAEL', printableName: 'Israel', iso3: 'ISR', numCode: 376)


c1 = ShippingCompany.create(name: "Kampanis", country_id: greece.id, address: "Fifth Avenue 23", telephone: "+30 2105544345", email: "info@kampanis.gr") 

admin = User.create(name: 'Admin', email: 'admin@example.com', password:'foobar', password_confirmation:'foobar', admin: true)

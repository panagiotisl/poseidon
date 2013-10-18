# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
other = Category.create(name:'Other')
shipping = Category.create(name:'Shipping')

affiliation = Affiliation.create(name: 'Other', category_id: other.id)
#affiliation = Affiliation.first
admin = User.create(name: 'Admin', email: 'admin@example.com', password:'foobar', password_confirmation:'foobar', affiliation_id: affiliation.id, admin: true)
Affiliation.create(name: 'Kampanis', category_id: shipping.id)

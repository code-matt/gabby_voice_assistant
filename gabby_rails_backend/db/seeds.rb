# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

matt = User.create(name: "Matt")
britta = User.create(name: "Britta")
brett = User.create(name: "Brett")
paul = User.create(name: "Paul")

Favorite.create(name: "skiing", user: matt)
Favorite.create(name: "coffee", user: matt)
Favorite.create(name: "drinking", user: brett)
Favorite.create(name: "ruby", user: brett)
Favorite.create(name: "magic the gathering", user: paul)

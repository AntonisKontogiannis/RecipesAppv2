# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create global settings
GlobalSetting.create(name: "admin_username", value: ["admin"])
GlobalSetting.create(name: "admin_password", value: ["password"])
GlobalSetting.create(name: "categories", value: ["Όσπριο", "Κρεατικά", "Γρήγορο φαγητό", "Street","Kιμάς","Zυμαρικά","Mακαρόνια", "Μπεσαμέλ", "Λαχανικά", "Λαδερό", "Πίτσα",
                                                "Σιτηρά","θαλασσινά","Φρούτα","Vegan"])
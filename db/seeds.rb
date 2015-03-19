# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << admin_user.email

user = User.new email: "email@example.com", password: "password"
user.skip_confirmation!
user.save

30.times {
	v = Video.create title: Faker::Lorem.sentence, author_id: User.first.id, description: Faker::Lorem.paragraph, value: 0, url: "r700iP4V_VM"
	v.category_list.add "fun"
	v.save
}

Playlist.create title: Faker::Lorem.sentence, author_id: User.first.id, video_ids: Video.all.pluck(:id)[0..9]
Playlist.create title: Faker::Lorem.sentence, author_id: User.first.id, video_ids: Video.all.pluck(:id)[10..19]
Playlist.create title: Faker::Lorem.sentence, author_id: User.first.id, video_ids: Video.all.pluck(:id)[20..29]
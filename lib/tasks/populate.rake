namespace :db do

  desc "Fill database"
  task :populate => :environment do
    require 'populator'
    require 'ffaker'
    password = "password"
    #[User].each(&:delete_all)

   #  User.populate 50 do |person|
   #    person.first_name    = Faker::Name.first_name
   #    person.last_name    = Faker::Name.last_name
   #    person.email   = Faker::Internet.email
   #    person.encrypted_password = User.new(:password => password).encrypted_password
   #    person.street_address  = Faker::Address.street_address
   #    person.city    = Faker::Address.city
   #    person.country    = Faker::Address.country
			# person.sign_in_count = 1
   #    person.bio = Faker::HipsterIpsum.words(num = 5)
   #    # person.skill_list.add(Faker::Skill.specialties(num = 7))

   #    person.scoutingjobs = false
   #    person.guru = false
   #    person.available = false
   #    person.guruinfo = Faker::Company.catch_phrase



   #  end

    # Playlist.populate 5 do |pl|
    #   pl.title = Faker::HipsterIpsum.sentence(word_count = 4)
    #   pl.price = 4
    #   pl.challange_id = 1
    #   pl.video_ids = [1,2,3,4,5] DIDNT WORK
    # end


    # Video.populate 5 do |vid|
    #   vid.title = Faker::Skill.specialty
    #   vid.author_id = '1'
    #   vid.speaker = '1'
    #   vid.description = Faker::Product.product_name
    #   vid.value = 0
    #   vid.video_id = 74263369
    # end

    # Post.populate 50 do |post|
    #   post.content = Faker::BaconIpsum.sentence(paragraph_count = 3)
    #   post.title = Faker::BaconIpsum.sentence(word_count = 7)
    #   post.category = "General"
    #   post.user_id = '84'
    #   post.slug = post.title
    #   post.up_votes = 1
    #   post.down_votes = 0
    # end




  end
end


100.times do |n|
  email = Faker::Internet.email
  name = Faker::Name.name
  birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
  password = "12345678"
  user = User.create!(
    email: email,
    password: password,
    password_confirmation: password,
    confirmed_at: Time.now
  )
  person = user.build_person
  user.save
  person.build_profile(name: name, birthday: birthday)
  person.save


  id = n + 1
  MailNotificationSetting.create!(
    message_flag: 1,
    like_flag: 1,
    matching_flag: 1,
    user_id: id
  )

  LikePoint.create!(
    balance: 3,
    user_id: id
  )
end
User.create! name: "Example User", email: "example@railstutorial.org",
  password: "111111", password_confirmation: "111111", admin: true,
  activated: true, activated_at: Time.zone.now

User.create! name: "Tran The Anh Tuan", email: "hihihohohehe91@gmail.com",
  password: "111111", password_confirmation: "111111", admin: true,
  activated: true, activated_at: Time.zone.now

User.create! name: "Duong Phuong Thao", email: "duongthao.1610@gmail.com",
  password: "111111", password_confirmation: "111111", admin: true,
  activated: true, activated_at: Time.zone.now

99.times do |n|
  name = FFaker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "banhxelangtu"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, activated: true,
    activated_at: Time.zone.now
end

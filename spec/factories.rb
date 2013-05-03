FactoryGirl.define do
  factory :user do |user|
	user.name 						 		"Ayoub IDRISSI"
	user.email								"ayoub@gmail.com"
	user.password							"123456789"
	user.password_confirmation				"123456789"
end
end
FactoryGirl.define do
  factory :user do
    email "user@cwb.com"
    password "password"
    password_confirmation "password"
    auth_token { Devise.friendly_token }
  end
end

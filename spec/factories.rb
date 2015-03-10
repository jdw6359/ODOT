FactoryGirl.define do

	factory :user do
		first_name "First"
		last_name "Last"
		sequence(:email){|n| "user#{n}@odot.com"}
		password "password"
		password_confirmation "password"
	end 

end
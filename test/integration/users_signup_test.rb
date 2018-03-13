require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid sign-up information" do
		get signup_path
		assert_no_difference "User.count" do
			post users_path, params: { user: { name:  "",
																				 email: "user@invalid",
																				 password: 						 "foo",
																				 password_confirmation: "bar" } }
		end
		assert_template "users/new"
		assert_select "div#error_explanation"
		assert_select "div.field_with_errors"
	end

	test "valid sign-up information" do
		get signup_path
		assert_difference "User.count", 1 do
			post users_path, params: { user: { name:  "Valid Example",
																				 email: "example@valid.yeah",
																				 password: 						 "validpass",
																				 password_confirmation: "validpass" } }
		end
		follow_redirect!
		assert is_logged_in?
		assert_template "users/show"
		assert_not flash.empty?
	end
end

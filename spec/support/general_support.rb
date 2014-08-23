def _create_and_login_test_user
	user = create(:test_user)
	login_as user
end
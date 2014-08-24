def _create_and_login_test_user
	user = create(:test_user)
	login_as user
end

def _one_hour_ago
	Time.now - 60*60
end

def _one_hour_ahead
	Time.now + 60*60
end
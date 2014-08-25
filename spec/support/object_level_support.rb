def _create_and_login_test_user
	user = create(:test_user)
	login_as user
end

def _one_hour_ago
	_n_hour_diff(-1)
end

def _six_hours_ago
	_n_hour_diff(-6)
end

def _one_hour_ahead
	_n_hour_diff(1)
end

def _n_hour_diff(n)
	Time.now + n*60*60
end

def _up_vote_n_times_for(post, n, start_user_id=0)
	_generate_n_votes_for(post, n, 1, start_user_id)
end

def _down_vote_n_times_for(post, n, start_user_id=0)
	_generate_n_votes_for(post, n, -1, start_user_id)
end

def _generate_n_votes_for(post, n, value, start_user_id)
	n.times { |i| post.votes.create(value: value, user_id: start_user_id + i) }
end

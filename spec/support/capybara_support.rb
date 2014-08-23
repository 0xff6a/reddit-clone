def _create_text_post(title, text)
	visit posts_path
	click_link 'Post New Text'
	fill_in 'new_post_title', with: title
	fill_in 'new_post_text', with: text
	click_on 'Post'
end

def _create_url_post(title, url)
	visit posts_path
	click_link 'Post New Link'
	fill_in 'new_post_title', with: title
	fill_in 'new_post_url', with: url
	click_on 'Post'
end
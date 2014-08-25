Week 9 Challenge @ Makers Academy: Reddit Clone (SkimdIt)
========================================================

Hosted on heroku @ ....

Ruby Version
------------

Ruby 2.1.2

Objectives:
-----------

Create a clone of reddit including posting of links or text, comments, voting on comments, a variety of ranking algorithms, nested replies to comments and search functionality.

Technologies used:
------------------
- Ruby on Rails
- Javascript
- jQuery & jQuery UI
- RSpec & Capybara for testing ruby components
- Poltergeist/Phantom JS for testing JavaScript components
- Bootstrap for styling & modals
- Postgres DB
- Factory girl for generating feature test objects

Functionality:
--------------

- Users can submit posts consisting of a title and either a link or text
- Users can vote posts up or down, but can only vote once on each post
- Users can comment on posts
- Users can reply to comments on posts
- Users have access to a number of views that sort posts according to the different ranking algorithms: default, fresh, controversial and rising
- Users can search the site for key words in a post title from the navigation bar

Ranking Algorithms:
-------------------
- Default (Hot): ranks posts according to total positive votes. Applies a hard time weighting 
- Fresh: ranks post according to time created only
- Controversial: ranks posts according to total number of votes (up and down) and total number of comments. Applies a soft time weighting
- Rising: ranks posts according to the ratio of upvotes to overall votes. Removes any posts older than 12 hours

Notes:
------
- User management uses devise gem

Running the application:
------------------------
- bin/rails server in CLI will open the app on port 3000
- rspec in CLI from the root directory will run the test suite 
- bin/rake db:seed will seed the database with sample entries to demonstrate functionality

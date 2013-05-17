# Blabber
A simple twitter clone for [Ruby Weekend 4](http://rubyweekend.com)

### Checking requirements

```ruby
ruby -v
# ruby 1.9.3p392 (2013-02-22 revision 39386) [x86_64-darwin12.3.0]
rails -v
# Rails 3.2.13
```

## Creating the app

	1. ```ruby rails new blabber --skip-test-unit```
	2. ```ruby cd blabber```
	3. ```ruby rails s```
	4. ```ruby git init```
	5. ```ruby git add .```
	6. ```ruby git commit -m "first commit"```
	7. delete public/index.html
	8. make a new file called site_controller.rb inside controllers folder
	9. add following code to site_controller.rb:
	```ruby
	class SiteController < ApplicationController
		def index
		end
	end
	```
	10. inside config/routes.rb at the top add:
	```ruby
	root :to => 'site#index'
	```
	11. make a new folder inside views called 'site'
	12. make a new file inside site folder called index.html.erb
	13. inside site/index.html.erb type 'Welcome to Blabber'
	14. ```ruby git add .```
	15. ```ruby git commit -m "add site index"```
	16. add foundation. your gem file should now look like this:
	```ruby
	source 'https://rubygems.org'

	gem 'rails', '3.2.13'
	gem 'jquery-rails'
	gem 'sqlite3'

	group :assets do
		gem 'sass-rails',   '~> 3.2.3'
		gem 'coffee-rails', '~> 3.2.1'
		gem 'uglifier', '>= 1.0.3'
		gem 'zurb-foundation'
	end
	```
	17. ```ruby bundle``` (server restart required)
	18. ```ruby rails g foundation:install``` (type "Y" after conflict alert)
	19. in layout/application.html.erb move this:
	```ruby <%= javascript_include_tag "application" %>```
			back into the header below this:
	```ruby <%= stylesheet_link_tag    "application" %>```
	20. add the following code to layouts/application.html.erb:
	```ruby
	<body>

		<div class="fixed">
			<nav class="top-bar">
				<ul class="title-area">
					<li class="name">
						<h1><a href="/">Blabber</a></h1>
					</li>
					<li class="toggle-topbar menu-icon">
						<a href="#"><span></span></a>
					</li>
				</ul>
				<section class="top-bar-section">
					<ul class="right">
						<li class="divider"></li>
						<li><a href="#">Sign In</a></li>
					</ul>
				</section>
			</nav>
		</div>

		<%= yield %>

	</body>
	```
	21. ```ruby git add .```
	22. ```ruby git commit -m "add foundation and top bar"```
	23.  





















### Resources
Congrats! You've built a rails app. Now it's time to go re-learn what you just did.
Here are some links to help you get started
- http://meetup.lvrug.org/
- http://www.codecademy.com/tracks/ruby
- http://www.codeschool.com/paths/ruby
- http://www.codeschool.com/courses/ruby-bits
- http://railsforzombies.org/
- http://jumpstartlab.com/courses
- http://railscasts.com/
- http://ruby.railstutorial.org/
- http://railsbest.com/
# Blabber
A simple twitter clone for [Ruby Weekend 4](http://rubyweekend.com)

## Checking requirements

```ruby
ruby -v
# ruby 1.9.3p392 (2013-02-22 revision 39386) [x86_64-darwin12.3.0]
rails -v
# Rails 3.2.13
```

## Creating the app

1) ```rails new blabber --skip-test-unit```  
2) ```cd blabber```  
3) ```rails s```  
4) ```git init```  
5) ```git add .```   
6) ```git commit -m "first commit"```   
7) delete public/index.html  
8) make a new file called site_controller.rb inside controllers folder  
9) add following code to site_controller.rb:
```ruby
class SiteController < ApplicationController
  def index
  end
end
```
10) inside config/routes.rb at the top add:
```ruby
root :to => 'site#index'
```
11) make a new folder inside views called "site"  
12) make a new file inside site folder called index.html.erb  
13) inside site/index.html.erb type "Welcome to Blabber"  
14) ```git add .```  
15) ```git commit -m "add site index"```   
16) add foundation. your gem file should now look like this:  
```ruby
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
17) ```bundle``` (server restart required)  
18) ```rails g foundation:install``` (type "Y" after conflict alert)  
19) in layout/application.html.erb move this:  
```ruby
<%= javascript_include_tag "application" %>
```
back into the header below this:  
```ruby
<%= stylesheet_link_tag    "application" %>
```
20) add the following code to layouts/application.html.erb:  
```html
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
21) ```git add . ```  
22) ```git commit -m "add foundation and top bar" ```  
23) in index.html.erb replace "Welcome to Blabber" with this:
```html
<div class="row" id="welcome">
  <div class="large-8 large-offset-2 columns">
    <div class="panel radius">
      <h2>Welcome to Blabber</h2>
    </div>
  </div>
</div>
```
24) make a new file inside assets/stylesheets called custom.css.scss  
25) paste the following code into custom.css.scss:
```scss
body {min-height: 540px; padding-bottom: 50px;}
#welcome, #signup, #signin, #new-blab, #edit-blab, #show-blab {margin-top: 80px;}
#welcome .panel {text-align: center;}
#welcome h3 {color: #777;}
.panel.white {background-color: #fff;}
.panel.light {background-color: #f3f3f3;}
.global.alert-box {text-align: center; font-size: 18px;}
.alert-box .close {z-index: 101; top: 14px;}
input {-webkit-appearance: none;}
li {list-style: none;}
#new-blab .secondary, #edit-blab .secondary {margin-left: 20px;}
a img {border: 1px solid #bbb;}
a img:hover {border: 1px solid #FC8E6C;}
#index-blab {
  margin-top: 40px;
  .panel {padding: 10px 16px;}
  .details {color: #bbb;}
  .details:hover {color: #2BA6CB;}
}
#show-blab {
  text-align: center;
  h2 {color: #999; text-shadow: 1px 1px 0px #fff;}
  h3 {margin-bottom: 0;}
  .button {margin: 0px 10px 15px}
  .white.panel {margin-bottom: 40px;}
}
#boom {
  color: #2E7979;
  font-size: 60px;
  line-height: 50px;
  margin-bottom: 50px;
  font-weight: bolder;
  text-shadow: -4px 4px 0px #00bdbd, -8px 8px 0px #01cccc, -12px 12px 0px #00e6e6;
}
.ransack.button {float: right; top: -46px; padding-bottom: 9px;}
.ransack.columns {height: 40px; margin-top: 5px;}
```
26) require it in application.css which should now look like this:
```css
*= require_self
*= require foundation_and_overrides
*= require custom
*= require_tree .
*/
```
27) ```git add . ```  
28) ```git commit -m "improve index and paste custom css" ```  
29) open models/user.rb and make it look like this:
```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end
```
30) ```rake db:migrate```  
31) make models/user.rb look like this:  
```ruby
class User < ActiveRecord::Base
 attr_accessible :name, :email, :password, :password_confirmation
 validates_uniqueness_of :email
 has_secure_password
end
```
32) add this to your gemfile: ```gem "bcrypt-ruby"```  
33) ```bundle```(server restart required)  
34) make a new file inside app/controllers called users_controller.rb  
35) add the following code to users_controller.rb:  
```ruby
class UsersController < ApplicationController

  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, notice: "prepare to blab!"
    else
      render "new"
    end
  end

end
```
36) add these two lines to config/routes.rb:  
```ruby
get 'signup', to: 'users#new', as: 'signup' 
resources :users, only: [:create]
```
37) create a folder inside of views called users  
38) create a new file in views/users called new.html.erb  
39) add the following code to users/new.html.erb:  
```html
<div class="row" id="signup">
	<div class="small-12 columns">

		<h1>Sign Up</h1>

		<%= form_for @user do |f| %>
			<% if @user.errors.any? %>
				<% @user.errors.full_messages.each do |message| %>
					<div class="alert-box alert"><%= message %></div>
				<% end %>
			<% end %>
			<div class="field">
				<%= f.label :name %><br>
				<%= f.text_field :name %>
			</div>
			<div class="field">
				<%= f.label :email %><br>
				<%= f.text_field :email %>
			</div>
			<div class="field">
				<%= f.label :password %><br>
				<%= f.password_field :password %>
			</div>
			<div class="field">
				<%= f.label :password_confirmation %><br>
				<%= f.password_field :password_confirmation %>
			</div>
			<div><%= f.submit "Sign Up", class: "button radius" %></div>
		<% end %>
	</div>
</div>
```
40) make your index.html.erb look like this:  
```html
<div class="row" id="welcome">
	<div class="large-8 large-offset-2 columns">
		<div class="panel radius">
			<h2>Welcome to Blabber</h2>
			<div class="row">
				<div class="large-6 large-offset-3 columns">
					<div class="panel radius white">
						<h3>if ur a noob</h3>
						<%= link_to "Sign Up", signup_path, class: "button radius" %>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
```
41) ```git add . ```  
42) ```git commit -m "add user model and sign up form" ```  
43) make application_controller.rb look like this:  
```ruby
class ApplicationController < ActionController::Base
 protect_from_forgery
 
 private

 def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
 end
 helper_method :current_user
 
end
```
44) add these two lines to to config/routes.rb:  
```ruby
get 'signin', to: 'sessions#new', as: 'signin'
get 'signout', to: 'sessions#destroy', as: 'signout'
resources :sessions, only: [:create]
```
45) make a new file called sessions_controller.rb inside app/controllers  
46) make sessions_controller.rb look like this:  
```ruby
class SessionsController < ApplicationController

 def new
 end

 def create
  user = User.find_by_email(params[:email])
  if user && user.authenticate(params[:password])
   session[:user_id] = user.id
   redirect_to root_url, notice: "greetings earthling!"
  else
   flash[:error] = "email or password is invalid"
   render "new"
  end
 end

 def destroy
  session[:user_id] = nil
  redirect_to root_url, notice: "see ya later alligator!"
 end

end
```































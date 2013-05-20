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
8) inside config/routes.rb at the top add:  
```ruby
root :to => 'pages#landing'
```
9) make a new file called pages_controller.rb inside controllers folder   
10) add following code to pages_controller.rb:  
```ruby
class PagesController < ApplicationController
  def landing
  end
end
```
11) make a new folder inside views called "pages"  
12) make a new file inside site folder called landing.html.erb   
13) inside pages/landing.html.erb type "Welcome to Blabber"  
14) ```git add .```  
15) ```git commit -m "add landing page"```   
16) add foundation. your gem file should now look like this:  
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

	<% if flash[:notice] %>
	  <div class="global alert-box">
	    <%= flash[:notice] %>
	    <a href="" class="close">&times;</a>
	  </div>
	<% elsif flash[:error] %>
	  <div class="global alert-box alert">
	    <%= flash[:error] %>
	    <a href="" class="close">&times;</a>
	  </div>
	<% end %>

  <%= yield %>

</body>
```
21) ```git add . ```  
22) ```git commit -m "add foundation and top bar" ```  
23) in landing.html.erb replace "Welcome to Blabber" with this:
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
28) ```git commit -m "improve landing and paste custom css" ```  
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
get 'signup', to: 'users#new' 
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
40) make your landing.html.erb look like this:  
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
get 'signin', to: 'sessions#new'
get 'signout', to: 'sessions#destroy'
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
47) make a new folder in app/views called sessions  
48) make a new file called new.html.erb inside views/sessions  
49) make sessions/new.html.erb look like this:  
```html
<div class="row" id="signin">
  <div class="small-12 columns">

    <h1>Sign In</h1>

    <%= form_tag sessions_path do %>
      <div class="field">
        <%= label_tag :email %><br>
        <%= text_field_tag :email, params[:email] %>
      </div>
      <div class="field">
        <%= label_tag :password %><br>
        <%= password_field_tag :password %>
      </div>
      <div><%= submit_tag "Sign In", class: "button radius" %></div>
    <% end %>
  </div>
</div>
```
50) in application.html.erb add the sign in logic to the nav:  
```html
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
        <% if current_user %>
          <li><a>Hi <%= current_user.name.split(' ')[0] %>!</a><li>
          <li class="divider"></li>
          <li><%= link_to "Sign Out", signout_path %></li>
        <% else %>
          <li class="divider"></li>
          <li><%= link_to "Sign In", signin_path %></li>
        <% end %>
      </ul>
    </section>
  </nav>
</div>
```
51) add session id assignment to create action in users_controller.rb as follows:   
```ruby
def create
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect_to root_url, notice: "prepare to blab!"
  else
    render "new"
  end
end
```
52) modify landing.html.erb as follows:  
```html
<div class="row" id="welcome">
  <div class="large-8 large-offset-2 columns">
    <div class="panel radius">
      <h2>Welcome to Blabber</h2>

      <% if current_user %>
        <div class="row">
          <div class="large-8 large-offset-2 columns">
            <div class="panel radius white">
              <h3>go do some blabbing!</h3>
            </div>
          </div>
        </div>
      <% else %>
        <div class="row">
          <div class="large-6 large-offset-3 columns">
            <div class="panel radius white">
              <h3>if ur a user</h3>
              <%= link_to "Sign In", signin_path, class: "button radius" %>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="large-6 large-offset-3 columns">
            <div class="panel radius white">
              <h3>if ur a noob</h3>
              <%= link_to "Sign Up", signup_path, class: "button radius" %>
            </div>
          </div>
        </div>
      <% end %>

    </div>
  </div>
</div>
```
53) ```git add . ```  
54) ```git commit -m "add session controller and sign in form" ```  
55) prepare for deployment by adding pg gem. gemfile should look like this:  
```ruby
source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'bcrypt-ruby'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation'
end

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
```
56) ```bundle```   
57) delete production from config/databse.yml, should look like this now:
```ruby
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000
```
58) add the following line anywhere in config/application.rb for heroku:  
```ruby
config.assets.initialize_on_precompile = false 
```
59) ```git add . ```  
60) ```git commit -m "add postgres and heroku configs" ```  
61) you should already have created a heroku account (https://id.heroku.com/signup)  
62) you should already have heroku toolbelt (https://toolbelt.heroku.com/) installed  
63) test connection by running ```heroku login```  
64) ```heroku create```  
65) ```git push heroku master```  
66) ```heroku run rake db:migrate```  
67) copy paste url into browser  
68) ```rails g scaffold blab```  
69) open migrate/######create_blabs.rb and make it look like this:  
```ruby
class CreateBlabs < ActiveRecord::Migration
  def change
    create_table :blabs do |t|
      t.string :text
      t.integer :user_id
      t.timestamps
    end
  end
end
```
70) ```rake db:migrate```   
71) make models/blab.rb look like this:  
```ruby
class Blab < ActiveRecord::Base
  attr_accessible :text
  validates_presence_of :text
  belongs_to :user
end
```
72) add the following line to models/user.rb:  
```ruby
has_many :blabs
```
73) in blabs_controller.rb on line 47 directly below "if @blab.save" add this:  
```ruby
current_user.blabs << @blab
```
74) in blabs_controller.rb change line 48 to say:  
```ruby
format.html { redirect_to blabs_path, notice: 'good job blabber mouth.' }
```
75) in blabs_controller.rb change line 64 to say:  
```ruby
format.html { redirect_to blabs_path, notice: 'good job blabber mouth.' }
```
76) in sessions_controller.rb change the following line:  
```ruby
redirect_to root_url, notice: "greetings earthling!"
```
to look like this instead:
```ruby
redirect_to blabs_path, notice: "greetings earthling!"
```
77) in users_controller.rb change the following line:  
```ruby
redirect_to root_url, notice: "prepare to blab!"
```
to look like this instead:
```ruby
redirect_to blabs_path, notice: "prepare to blab!"
```
78) change the title link in the pages/landing.html.erb nav as follows:  
```html
<h1><a href="/blabs">Blabber</a></h1>
```
79) in stylesheets folder delete scaffolds.css.scss and blabs.css.scss  
80) ```git add . ```  
81) ```git commit -m "blab scaffold, model relationships, blabs redirects" ```  
82) make views/blabs/new.html.erb look like this:  
```html
<div class="row" id="new-blab">
  <div class="small-12 columns">
    <h1>New blab</h1>
    <%= render 'form' %>
  </div>
</div>
```
83) make views/blabs/edit.html.erb look like this:  
```html
<div class="row" id="edit-blab">
  <div class="small-12 columns">
    <h1>Edit blab</h1>
    <%= render 'form' %>
  </div>
</div>
```
84) make views/blabs/_form.html.erb look like this:  
```html
<%= form_for @blab do |f| %>
  <% if @blab.errors.any? %>
    <% @blab.errors.full_messages.each do |message| %>
      <div class="alert-box alert"><%= message %></div>
    <% end %>
  <% end %>

  <div class="panel radius">
    <%= f.text_field :text, {placeholder: 'put your blabber here...'} %>
  </div>

  <%= f.submit "blabber time", class: "button radius inline" %>
  <%= link_to 'go back', blabs_path, class: "button radius inline secondary" %>
<% end %>
```
85) make views/blabs/index.html.erb look like this:  
```html
<div class="row" id="index-blab">
  <div class="small-12 columns">
    <h1>All The Blabber</h1>

    <%= link_to 'new blab', new_blab_path, class: "button radius" %>

    <% if @blabs.present? %>
      <ul id="blab-list">
        <% @blabs.each do |blab| %>
          <li class="blab">
            <div class="panel radius">
              <strong><%= blab.user.name.split(' ')[0] %>: </strong>
              <%= blab.text %><br>
              <%= link_to 'details', blab, class: 'details' %>
            </div>
          </li>
        <% end %>
      </ul>
    <% else %>
      <div class="panel radius">
        <strong>crickets...</strong>
      </div>
    <% end %>
  </div>
</div>
```
86) make views/blabs/show.html.erb look like this:  
```html
<div class="row" id="show-blab">
  <div class="large-8 large-offset-2 columns">
    <div class="panel light radius">
      <h2>
        ...on <%= @blab.created_at.strftime("%b %d, %Y") %>
        <br>this was blabbed by
      </h2>
      <p id="boom"><%= @blab.user.name.split(' ')[0] %>!</p>
      <div class="row">
        <div class="large-10 large-offset-1 columns">
          <div class="white panel radius">
            <h3>"<%= @blab.text %>"<h3>
          </div>
        </div>
      </div>
      <%= link_to 'go blabber', blabs_path, class: "button radius secondary" %>
      <%= link_to 'edit blab', edit_blab_path, class: "button radius secondary" %>
    </div>
  </div>
</div>
```   
87) define authentication method in application_controller below the word private:  
```ruby
def authorize
  if current_user.nil?
    flash[:error] = "please login first"
    redirect_to signin_path
  end 
end
```
88) add a before filter to the top of blabs controller:  
```ruby
before_filter :authorize
```
89) ```git add . ```  
90) ```git commit -m "add blab views and authentication filter" ```  
91) ```git push heroku```  
92) ```heroku run rake db:migrate```  
93) in blabs/index.html change ```<li class="blab">``` as follows:  
```html
<li class="blab">
  <div class="panel radius">
    <div class="row">
      <div class="small-3 large-1 columns">
        <%= image_tag avatar_url(blab.user) %>
      </div>
      <div class="small-9 large-11 columns">
        <strong><%= blab.user.name.split(' ')[0] %>: </strong>
        <%= blab.text %><br>
        <%= link_to 'details', blab, class: 'details' %>                                            
      </div>
    </div>
  </div>
</li>
```
94) in application_helper, add the following method:  
```ruby
def avatar_url(user)
  gravatar_id = Digest::MD5::hexdigest(user.email).downcase
  "http://gravatar.com/avatar/#{gravatar_id}.png"
end
```
95) in users_controller.rb add a show method:  
```ruby
def show
  @user = current_user
  @blabs = @user.blabs
end
```
96) in config routes add show to the users resource as follows:  
```ruby
resources :users, only: [:create, :show] 
```
97) make a new file in views/users called show.html.erb that looks like this:  
```html
<div class="row" id="index-blab">
  <div class="small-12 columns">
    <h1><%= @user.name.split(' ')[0] %>'s Blabber</h1>


    <% if @blabs.present? %>
      <ul id="blab-list">
        <% @blabs.each do |blab| %>
          <li class="blab">
            <div class="panel radius">
              <div class="row">
                <div class="small-3 large-1 columns">
                  <%= image_tag avatar_url(blab.user) %>
                </div>
                <div class="small-9 large-11 columns">
                  <strong><%= blab.user.name.split(' ')[0] %>: </strong>
                  <%= blab.text %><br>
                  <%= link_to 'details', blab, class: 'details' %>                                            
                </div>
              </div>
            </div>
          </li>
        <% end %>
      </ul>
    <% else %>
      <div class="panel radius">
        <strong>crickets...</strong>
      </div>
    <% end %>
  </div>
</div>
```
98) in blabs/index.html.erb wrap gravatar in an a-tag as follows:  
```html
<a href="/users/<%= blab.user.id %>"><%= image_tag avatar_url(blab.user) %></a>
```
99) ```git add . ```  
100) ```git commit -m "add users show action and gravatars" ```  
101) make a new file in views/blabs called _list.html.erb that looks like this:  
```html
<% if @blabs.present? %>
  <ul id="blab-list">
    <% @blabs.each do |blab| %>
      <li class="blab">
        <div class="panel radius">
          <div class="row">
            <div class="small-3 large-1 columns">
              <a href="/users/<%= blab.user.id %>"><%= image_tag avatar_url(blab.user) %></a>
            </div>
            <div class="small-9 large-11 columns">
              <strong><%= blab.user.name.split(' ')[0] %>: </strong>
              <%= blab.text %><br>
              <%= link_to 'details', blab, class: 'details' %>                                            
            </div>
          </div>
        </div>
      </li>
    <% end %>
  </ul>
<% else %>
     <div class="panel radius">
          <strong>crickets...</strong>
     </div>
<% end %>
```
102) replace your entire blabs/index.hml.erb with this:  
```html
<div class="row" id="index-blab">
  <div class="small-12 columns">
    <h1>All The Blabber</h1>
    <%= link_to 'new blab', new_blab_path, class: "button radius" %>
    <%= render 'list' %>
  </div>
</div>
```
103) replace your entire users/show.html.erb with this:  
```html
<div class="row" id="index-blab">
  <div class="small-12 columns">
    <h1><%= @user.name.split(' ')[0] %>'s Blabber</h1>
    <%= render 'blabs/list' %>
  </div>
</div>
```
104) in models/user.rb add the following method  
```ruby
def first_name
  self.name.split(' ')[0]
end
```
105) replace all instances of ```.name.split(' ')[0]``` with ```.first_name```  
  
106) add this to your gemfile: ``` gem 'ransack' ```  
107) ```bundle```  
108) make the index action of blabs_controller look like this:  
```ruby
def index
  @search = Blab.search(params[:q])
  @blabs = @search.result


  respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @blabs }
  end
end
```
109) add to blabs/index.html below link_to 'new blab' and above render 'list':
```html
<%= search_form_for @search do |f| %>
  <div class="row">
    <div class="small-12 columns ransack">
      <%= f.text_field :text_cont, {placeholder: 'search the blabber...'} %>
      <%= f.submit "search", class: "ransack button secondary small" %>
    </div>                
  </div>
<% end %>
```
110) ```git add . ```  
111) ```git commit -m "first_name method, dry up views, ransack" ```  
112) ```git push heroku```

### completed app: http://vast-eyrie-1275.herokuapp.com/

### more resources:

http://meetup.lvrug.org/

http://www.codeschool.com/

http://guides.rubyonrails.org/

http://ruby.bastardsbook.com/

http://www.ruby-doc.org/

http://railscasts.com/

http://ruby.railstutorial.org/

http://rubymonk.com/










|     Project | Information                                                                          |
|------------:|:-------------------------------------------------------------------------------------|
| Domain:     | [Coding Dojo](http://codingdojo.com) (cd)                                            |
| Topic:      | Ruby on Rails (ror) <br> Understanding Rails - Controllers and Views (03controller)  |
| Assignment: | Rails Survey Form (02survey)                                                         |
| Repository: | cd-ror-03controller-02survey                                                         |

~~~

---------------
#1: Start project
---------------

# Create new project
rails new rails-survey-form

# Change to new directory
cd rails-survey-form


---------------
#2: Update Gemfile
---------------

URL: https://github.com/josevalim/rails-footnotes
Rails footnotes displays footnotes in your application for easy debugging, 
such as sessions, request parameters, cookies, filter chain, routes, 
queries, etc.

edit> Gemfile
  - Uncomment: gem 'bcrypt-ruby', '~> 3.1.2'      # Using bcrypt (3.1.7)
  - Add: gem 'hirb'                               # Using hirb (0.7.2)
  - Add: gem 'rails-footnotes', '>= 4.0.0', '<5'  # Installing rails-footnotes (4.0.1)

bundle install

rails generate rails_footnotes:install


---------------
#3: Create controllers
---------------

# Default RESTful Routing Controllers
# rails g controller <project-name> index new create show edit update destroy 

# Controllers needed for this project
rails g controller Surveys index new create show edit update destroy result


---------------
#4: Create models/tables
---------------

NA


---------------
#5: edit: app/assets/stylesheets/surveys.css.scss
---------------

#greenbox{
  background-color: lightgreen;
  display: inline-block;
  margin: 10px;
  width: 600px;
  padding: 5px;
}

#results_display{
  border: 1px solid black;
  width: 600px;
  margin: 10px;
  padding: 5px;
}

---------------
#6: edit: app/controllers/surveys_controller.rb
---------------

class SurveysController < ApplicationController
  def index
  end

  def new
  end

  def create

    session[:user] = params

    flash[:name] = params[:name]
    flash[:loc] = params[:loc]
    flash[:lang] = params[:lang]
    flash[:comm] = params[:comm]

    if session[:count]
      session[:count] += 1
    else
      session[:count] = 1
  end

    flash[:count] = session[:count]

    redirect_to('/result')
  end

  def result
    @user = session[:user]
  end

end

---------------
#7: edit: app/views/surveys/new.html.erb
---------------

<h1>Rails Survey Form</h1>
<!-- <p>Find me in app/views/surveys/new.html.erb</p> -->

<form action='/surveys' method='post'>
  <%= tag(:input,:type =>"hidden",:name => request_forgery_protection_token.to_s,:value => form_authenticity_token)%>

  <h3>Your Name:</h3>
  <input type='text' name='name'>

  <h3>Dojo Location:</h3>
  <select name='loc'>
    <option value='Mountain View'>Mountain View</option>
    <option value='Seattle'>Seattle</option>
    <option value='Afghanistan'>Afghanistan</option>
  </select>

  <h3>Favorite Language:</h3>
  <select name='lang'>
    <option value='Javascript'>Javascript</option>
    <option value='Ruby'>Ruby</option>
    <option value='PHP'>PHP</option>
    <option value='HTML'>HTML</option>
    <option value='Node.js'>Node.js</option>
  </select><br>

  <h3>Comments?</h3>
  <textarea rows='3' cols='40' name='comm'></textarea>
  <input type='submit'>
</form>

---------------
#8: app/views/surveys/result.html.erb
---------------

<h2>Results</h2>
  <% if flash[:count]%>
  <div id='greenbox'>
    <p>Thanks for submitting this form! You have submitted this form <%= flash[:count] %> times now.</p>
  </div>
  <% end %>
<div id='results_display'>
  Flash Name: <%= flash[:name] %><br>
  Flash Location: <%= flash[:loc] %><br>
  Flash Language: <%= flash[:lang] %><br>
  Flash Comments: <%= flash[:comm] %><br><br>

  @User Name: <%= @user['name'] %><br>
  @User Location: <%= @user['loc'] %><br>
  @User Language: <%= @user['lang'] %><br>
  @User Comments: <%= @user['comm'] %><br><br>

  <!-- <a href="<%=new_survey_path%>">Go Back</a> -->
  <a href="/surveys/new"><input type='submit' value='Go Back'></a>
</div>


---------------
#9: edit: config/routes.rb
---------------

RailsSurveyForm::Application.routes.draw do::Application.routes.draw do

  resources :surveys

  get "/result" => 'surveys#result'

  root 'surveys#new'

end


---------------
#10: Start server 
---------------

rails server


---------------
#11: Load application in browser
---------------

http://localhost:3000

~~~



# Recipes

A simple website application where you can add your cooking recipes. 

This is a Ruby on Rails project built from a [Udemy Course](https://www.udemy.com/pro-ruby-on-rails-rails5/)

The app is deployed on [Heroku](https://desolate-fjord-91325.herokuapp.com/)... still work in progress, but the main features are available. 

## Built With

* Rails 5.2.2 
* Ruby 2.4.2
* Backend Database with Postgresql 
* Tests with built-in testing framework : Minitest
* Adding rails Rspec to test some models
* Styling with Bootstrap 
* Deployment with Heroku 

## Getting Started

To get a copy of the project in your local machine :

```
git clone https://github.com/Pablo123GitHub/recipes.git
```

Then install the dependencies :

```
bundle install 
```

And the project can then be launched on your local machine with (port 3000) 
```
rails s
```

## Running the tests

In order to run all the tests (Minitest), you can run the following command : 

```
rails t
```

Midway through the project, I have added Rspec gem in order to run testing on the Ingredient model. To run the tests on the Ingredient model, please run the following : 

```
rspec
```

You should see loads of green dots showing that the tests are passing. 

### What are the current tests : 

Two types of test: Models testing and Integration testing

- For models testing, we test that validations are being correctly enforced. For example, if we say in the model that the name must be present, the test will check if we have an invalid record when we try to create a chef object without a name 

- For integration testing, we try to reproduce the user experience. For example, do we get the correct edit chef view when we  are directed to the edit page? Do we see an error message on the view when we try to edit with an invalid attribute? 

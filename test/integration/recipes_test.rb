require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  def setup 
    @chef = Chef.create!(chefname: "John", email: "john@whatever.com", password: "password", password_confirmation:"password")

    @recipe = Recipe.create(name:"Seafood Paella", description:"delish Spanish food", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken saute", description: "delish again real good")
    @recipe2.save
  end 
 

  test "should get /recipes" do   
    get recipes_url
    assert_response :success
 end 

  test "should get recipes listing" do   
    get recipes_path 
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    
  end 

  test "should get recipes show" do 
    sign_in(@chef, "password")
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body 
    assert_match @chef.chefname, response.body 
    assert_select "a[href=?]", edit_recipe_path(@recipe), text: "Edit recipe"
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete recipe"
    assert_select "a[href=?]", recipes_path, text: "Go back to Recipes list"
  end 

 test "create new valid recipe" do   
  get new_recipe_path
  assert_template 'recipes/new'
  name_of_recipe = "nice dish"
  description_of_dish= "buy microwave oven food"
  sign_in(@chef, "password")
  assert_difference "Recipe.count" do   
    post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_dish } }
  end 
  follow_redirect!
  assert_match name_of_recipe.capitalize, response.body
  assert_match description_of_dish, response.body
  assert_equal 'Recipe was created successfully ', flash[:success]

 end 

 test "reject invalid recipe submission" do   
  get new_recipe_path
  assert_template 'recipes/new'
  assert_no_difference 'Recipe.count' do   
    post recipes_path, params: { recipe: { name: " ", description: " "}}
  end 
  assert_template 'recipes/new'
  assert_select 'h2.panel-title'
  assert_select 'div.panel-body'
 end 


end

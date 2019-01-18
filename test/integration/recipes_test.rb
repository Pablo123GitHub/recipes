require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  def setup 
    @chef = chefs :one
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
    assert_match @recipe.name, response.body 
    assert_match @recipe2.name, response.body
  end 


end

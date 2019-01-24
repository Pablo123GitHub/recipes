require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = chefs :one
    @recipe = Recipe.create(name:"Seafood Paella", description:"delish Spanish food", chef: @chef)
  end 

  test "reject invalid recipe update" do   
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: "  ", description: " Some description"}}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 

  test "Successfully updates" do   
      get edit_recipe_path(@recipe)
      assert_template 'recipes/edit'
      name_dish = "Vegetarian moussaka"
      description_steps = "describe the steps to build this thing"
      patch recipe_path(@recipe), params: { recipe: {name: name_dish, description: description_steps}}
      # follow_redirect!
      assert_redirected_to @recipe
      assert_not flash.empty?
      @recipe.reload
      assert_match name_dish.capitalize, @recipe.name
      assert_match description_steps, @recipe.description
      assert_equal 'Recipe was updated successfully ', flash[:success]
  end 



end

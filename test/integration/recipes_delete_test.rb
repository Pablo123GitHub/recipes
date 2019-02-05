require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup 
    @chef = Chef.create!(chefname: "John", email: "john@whatever.com", password: "password", password_confirmation:"password")
    @recipe = Recipe.create(name:"Seafood Paella", description:"delish Spanish food", chef: @chef)
  end 

  test "successfully deletes a recipe" do   
    post login_path, params: { session: { email: @chef.email, password: @chef.password} }
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete recipe"
    assert_difference 'Recipe.count', -1, "An article should be destroyed" do   
      delete recipe_path(@recipe)
    end 
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end 

end

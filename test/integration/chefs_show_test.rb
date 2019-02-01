require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "John", email: "john@whatever.com", password: "password", password_confirmation:"password")
    @recipe = @chef.recipes.build(name:"delicious dish", description: "just awesomeness on a plate")
    @recipe.save
  end

  test "should get /chefs" do 
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end 




end

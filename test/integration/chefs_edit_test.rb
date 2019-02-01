require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "John", email: "john@whatever.com", password: "password", password_confirmation:"password")
    @recipe = Recipe.create(name:"Seafood Paella", description:"delish Spanish food", chef: @chef)
  end 
 
  test "reject invalid chef update" do   
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname:"  ",email: "  "}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 

  test "successful chef update " do   
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname:"JohnJohn", email: "johnjohn@email.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "JohnJohn", @chef.chefname
    assert_match "johnjohn@email.com", @chef.email
  end 

end

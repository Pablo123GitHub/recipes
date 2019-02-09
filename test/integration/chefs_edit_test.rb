require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "John", email: "john@whatever.com", password: "password", password_confirmation:"password")
    @chef2 = Chef.create!(chefname: "John2", email: "john2@email2.com", password: "password", password_confirmation:"password")
    @admin_user = Chef.create!(chefname: "JohnAdmin", email: "john@admin.com", password: "password", password_confirmation:"password", admin: true)

    @recipe = Recipe.create(name:"Seafood Paella", description:"delish Spanish food", chef: @chef)
  end 
 
  test "reject invalid chef update" do 
    sign_in(@chef, "password")  
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname:"  ",email: "  "}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 

  test "successful chef update " do   
    sign_in(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname:"JohnJohn", email: "johnjohn@email.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "JohnJohn", @chef.chefname
    assert_match "johnjohn@email.com", @chef.email
  end 

  test "accept edit attempt by admin user " do    
    sign_in(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname:"editedName", email: "editedemail@email.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "editedName", @chef.chefname
    assert_match "editedemail@email.com", @chef.email
  end 

  test "reject any edit attempt coming from a NON admin user" do    
    sign_in(@chef2, "password")
    patch chef_path(@chef), params: {chef: {chefname:"editedname", email: "editedemail2@email2.com"}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_no_match "editedname", @chef.chefname
    assert_no_match "editedemail2@email2.com", @chef.email
    assert_match "John", @chef.chefname
    assert_match "john@whatever.com", @chef.email
  end 

end

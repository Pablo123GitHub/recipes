require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "John", email: "john@whatever.com", password: "password", password_confirmation:"password")
  end 

  test "should get /chefs" do   
    get chefs_url
    assert_response :success
  end 

  test "should get chefs listing" do    
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname
  end   

  test "should delete chef" do   
    sign_in(@chef, "password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference "Chef.count", -1 , "a chef should be deleted" do    
      delete chef_path(@chef) 
    end 
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end 
  




end

require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  test "get the signup form" do   
    get signup_path
    assert_response :success
  end 

  test "reject an invalid singup" do    
    get signup_path
    assert_no_difference "Chef.count" do 
      post chefs_path, params: { chef: { chefname: "  ", email: "  ", password: "password", 
                              password_confirmation:""}}
      end 
    assert_template "chefs/new"
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 

  test "accept a valid signup" do   
    get signup_path
    assert_difference "Chef.count" do 
      post chefs_path, params: { chef: { chefname: "Sonita", email: "sonia@email.com", password: "password", 
                              password_confirmation:"password"}}
      end 
    follow_redirect!
    assert_template "chefs/show"
    assert_equal 'Welcome Sonita', flash[:success]

  end




end

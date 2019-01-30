require 'test_helper'

class RecipeTest < ActiveSupport::TestCase 
  
    # def setup 
    #     @chef = chefs :one   
    #     @recipe = @chef.recipes.build(name:"delicious dish", description: "just awesomeness on a plate")
    # end   
    def setup
        @chef = Chef.create!(chefname: "John", email: "john@whatever.com", password: "password", password_confirmation:"password")
        @recipe = @chef.recipes.build(name:"delicious dish", description: "just awesomeness on a plate")
    end 

    test "recipe without chef should be invalid" do   
        @recipe.chef_id = nil 
        assert_not @recipe.valid?
    end 

    test "Recipe should be valid" do   
        assert @recipe.valid? 
    end 

    test "name should be present" do   
        @recipe.name = " "
        assert_not @recipe.valid? 
    end 

    test "Description should be present" do   
        @recipe.description = "   "
        assert_not @recipe.valid? 
    end 

    test "desc shouldnot be less than 5 characters" do  
        @recipe.description = "a" *3
        assert_not @recipe.valid? 
    end 

    test "desc should not be more than 500 char." do   
        @recipe.description = "a" *501
        assert_not @recipe.valid? 
    end 
end 
require 'test_helper'

class RecipeTest < ActiveSupport::TestCase 
    def setup
        @recipe = Recipe.new(name:"Pizza tartiflette ", description:"Amazing dish from out of this world")
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
require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it "creates a valid instance of Ingredient" do    
    expect(Ingredient.new(name:"herbs")).to be_valid
  end 
  it "has a unique name for ingredient" do 
    Ingredient.create(name:"mushrooms")
    ingredient = Ingredient.new(name:"mushrooms")
    
    expect(ingredient).to_not be_valid
  end 

  it "is not valid if no name is present" do    
    empty_ingredient = Ingredient.new(name:"    ")
    expect(empty_ingredient).to_not be_valid
  end 
end

require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject {
    described_class.new(name:"mushrooms")
  }


  it "creates a valid instance of Ingredient" do    
    expect(subject).to be_valid
  end 
  it "has a unique name for ingredient" do 
    subject.save
    ingredient = Ingredient.new(name:subject.name)
    
    expect(ingredient).to_not be_valid
  end 

  it "is not valid if no name is present" do    
    subject.name = "     "
    expect(subject).to_not be_valid
  end 

  it "is not valid if the name is too short" do   
    subject.name = "a"*2
    expect(subject).to_not be_valid
  end 

  it "is not valid if the name is too long" do  
    subject.name = "a"*30 
    expect(subject).to_not be_valid
  end 
end

require 'test_helper'


class ChefTest < ActiveSupport::TestCase 

    def setup
        @chef = Chef.new(chefname:"Marie", email: "marie@goodchef.com" )
    end 

    test "should be valid" do   
        assert @chef.valid?
    end 

    test "name should be present" do   
        @chef.chefname = "  "
        assert_not @chef.valid?
    end 

    test "should be less than 30 characters" do   
        @chef.chefname = "a" *31
        assert_not @chef.valid?
    end 

    test "email should be present " do   
        @chef.email = "   "
        assert_not @chef.valid?  
    end 

    test "email should not be too long" do   
        @chef.email = "q" *256
        assert_not @chef.valid?  
    end 

    test " email should accept correct format " do   
        valid_emails = %w[user@emailc.com ASDFASDF@hga.com M.fida@hsdfkj.ca john+smith@co.uk.org]
        valid_emails.each do |valids| 
        @chef.email = valids   
        assert @chef.valid?, "#{valids.inspect} should be valid"
        end 
    end 

    test "email should not accept wrong format" do   
        invalid_emails = %w[masj@jsdhf bksdhf@fejler,com asjdflajdf@jkdsfjl. ldajfkdsfj@jdlkfj+sdfgs.com ]
        invalid_emails.each do |invalids| 
            @chef.email = invalids 
            assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
        end 
    end 

    test "email should be unique and case insensitive" do   
        duplicate_chef = @chef.dup 
        duplicate_chef.email = @chef.email.upcase
        @chef.save 
        assert_not duplicate_chef.valid? 
    end 


end 
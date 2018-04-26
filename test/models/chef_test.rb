require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    
    def setup
      @chef = Chef.new(chefname: "Steve", email: "steve@steve.com", password: "password", password_confirmation: "password")     
    end
    
    test "should be valid" do
        assert @chef.valid?
    end
    
    test "chef should be present" do
       @chef.chefname = ""
        assert_not @chef.valid?
    end
 
    test "email should be present" do
       @chef.email = ""
       assert_not @chef.valid? 
    end
    
    test "chefname should be less than 30 chars" do
       @chef.chefname = "a" * 31 
       assert_not @chef.valid?
    end
    
    test "email should not be too long" do
       @chef.email = "a"*245 + "@steve.com"
         assert_not @chef.valid?
    end
    
    test "email should accept correct format" do
       valid_emails = %w[user@example.com stev@gmail.com s.first@yahoo.ca john+smith@co.uk.org]
        valid_emails.each do |valids|
            @chef.email = valids
        assert @chef.valid?, "#{valids.inspect} should be valid"
        end
    end
    
    test "should reject invalid emails" do
        invalid_emails = %w[mashur@example steve.com]
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
    
    test "email should be lowercase before hitting DB" do
       mixed_email = "JohN@eXample.com"
        @chef.email = mixed_email
        @chef.save
        assert_equal mixed_email.downcase, @chef.reload.email
    end
    
    test "password should be present" do
       @chef.password = @chef.password_confirmation = " "
        assert_not @chef.valid?
    end
    
    test "password should be at least 5 chars" do
       @chef.password = @chef.password_confirmation = "x"*4
        assert_not @chef.valid?
    end

end
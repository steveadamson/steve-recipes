require 'test_helper'

class ChefListingTestTest < ActionDispatch::IntegrationTest
def setup
        @chef = Chef.create!(chefname: "Steve", email: "steve@example.com", password: "password", password_confirmation: "password")
        @chef1 = Chef.create!(chefname: "Steve1", email: "steve1@example.com", password: "password", password_confirmation: "password")
        @recipe = Recipe.create(name: "Veg saute", description: "Lots of veggies", chef: @chef)
        @recipe2 = @chef.recipes.build(name: "Chicken", description: "Chicken dish")
        @recipe2.save
    end
    
    test "should get index" do
        get chefs_url
        assert_response :success
    end
    
    test "should list chefs" do
       get chefs_path
       assert_template 'chefs/index'
       assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname
       assert_select "a[href=?]", chef_path(@chef1), text: @chef1.chefname
    end
    
end

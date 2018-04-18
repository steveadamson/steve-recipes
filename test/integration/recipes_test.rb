require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
 
    def setup
        @chef = Chef.create!(chefname: "Steve", email: "steve@example.com")
        @recipe = Recipe.create(name: "Veg saute", description: "Lots of veggies", chef: @chef)
        @recipe2 = @chef.recipes.build(name: "Chicken", description: "Chicken dish")
        @recipe2.save
    end
    
    test "should get index" do
        get recipes_url
        assert_response :success
    end
    
    test "should list recipes" do
       get recipes_path
       assert_template 'recipes/index'
       assert_match @recipe.name, response.body
       assert_match @recipe2.name, response.body
    end
end

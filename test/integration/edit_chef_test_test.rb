require 'test_helper'

class EditChefTestTest < ActionDispatch::IntegrationTest
    
    def setup
        @chef = Chef.create!(chefname: "Steve", email: "steve@example.com", password: "password", password_confirmation: "password")
    end
    
    test "reject invalid edit" do
       get edit_chef_path(@chef)
        assert_template 'chefs/edit'
       patch chef_path(@chef), params: { chef: { chefname: " ", email: "steve@steve.com "}} 
       assert_template 'chefs/edit'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
    
    test "accept valid edit" do
        get edit_chef_path(@chef)
        assert_template 'chefs/edit'
        patch chef_path(@chef), params:{ chef:{  chefname: "Steve2", email: "steve2@steve.com"}} 
        assert_redirected_to @chef
        assert_not flash.empty?
        @chef.reload
        assert_match "Steve2", @chef.chefname
        assert_match "steve2@steve.com", @chef.email
    end
end

require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  USER_PWD = "password"

  setup do
    @user = User.create(username: "john", email: "john@axample.com", password: USER_PWD, admin: true)
  end

  test 'get new category form and create category' do
    sign_in_as(@user, USER_PWD)

    get new_category_path

    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: 'developer'}
    end
    assert_template 'categories/index'
    assert_match 'developer', response.body
  end

  test 'invalid category submission should display new' do
    sign_in_as(@user, USER_PWD)

    get new_category_path

    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: ''}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
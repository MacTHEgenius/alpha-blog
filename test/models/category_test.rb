require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'sports')
  end

  # Test Category.new
  test 'category should be valid' do
    assert @category.valid?
  end

  # Test validates :name, presence: true
  test 'name should be present' do
    @category.name = ' '
    assert_not @category.valid?
  end

  # Test validates_uniqueness_of :name
  test 'name should be unique' do
    @category.save
    category2 = Category.new(name: 'sports')
    assert_not category2.valid?
  end

  # Test length maximum
  test 'name should not be too long' do
    @category.name = 'a' * 26
    assert_not @category.valid?
  end

  # Test length minimum
  test 'name should not be too short' do
    @category.name = 'aa'
    assert_not @category.valid?
  end

end
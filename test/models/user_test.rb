require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should create user' do
    user                       = User.new
    user.name                  = 'Test'
    user.username              = 'username'
    user.email                 = 'test@speakeasy.com'
    user.password              = 'secret'
    user.password_confirmation = 'secret'

    assert user.save
  end

  test 'should find event' do
    user_id = users(:one).id
    assert_nothing_raised { User.find(user_id) }
  end

  test 'should update event' do
    user = users(:two)
    assert user.update_attributes(:name => 'new name')
  end

  test 'should destroy event' do
    user = users(:two)
    user.destroy
    assert_raise(ActiveRecord::RecordNotFound) { User.find(user.id) }
  end

  test 'should not create a user without name, username, email' do
    user = User.new
    assert !user.valid?
    assert user.errors[:name].any?
    assert user.errors[:username].any?
    assert user.errors[:email].any?
    assert_equal ["can't be blank"],user.errors[:name]
    assert_equal ["can't be blank"],user.errors[:username]
    assert_equal ["can't be blank",'is invalid'],user.errors[:email]
  end

  test 'should not create a user without a valid email' do
    user                       = User.new
    user.name                  = 'Test'
    user.username              = 'username'
    user.email                 = 'test-speakeasy.com'
    user.password              = 'secret'
    user.password_confirmation = 'secret'

    assert !user.valid?
 end


end

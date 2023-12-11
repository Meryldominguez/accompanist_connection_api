require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "first_name should not be blank" do
    @user.first_name = nil
    assert_not @user.valid?
  end
  test "last_name should not be blank" do
    @user.last_name = nil
    assert_not @user.valid?
  end
  test "email should not be blank" do
    @user.email = nil
    assert_not @user.valid?
  end
  test "email should be formatted correctly" do
    @user.email = "notanemail"
    assert_not @user.valid?
  end

  test "email should not be duplicate" do
    @new_user = users(:two)
    @user.email = @new_user.email
    assert_not @user.valid?
  end

  test 'user should have role' do
    assert_not @user.role? :new_role
  
    @user.roles << Role.new(name: 'new_role')
  
    assert @user.role? :admin
  end
end

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user_count = users.count
  end
  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    @new_user = { email: 'alex@gmail.com', first_name: 'Alex', last_name: 'Nowakowski' } 

    assert_difference("User.count", 1) do
      post users_url, params: { user: @new_user }, as: :json
    end
    assert_response :created
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success

    response_user = JSON.parse(response.body).with_indifferent_access
    assert_equal response_user[:id], @user.id
    assert_equal response_user[:first_name], @user.first_name
  end

  test "should update user" do
    new_email = "new@email.com"

    patch user_url(@user), params: { user: { email: new_email } }, as: :json
    assert_response :success

    response_user = JSON.parse(response.body).with_indifferent_access
    assert_equal response_user[:email], new_email
    assert_equal User.find(@user.id).email, new_email
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user), as: :json
    end

    assert_response :no_content
  end
end

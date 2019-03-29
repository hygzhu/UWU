
class UsersLoginTest < ActionDispatch::IntegrationTest

    def setup
        @activated_user = users(:michael)
    end

    test "login with invalid information" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email: "", password: "" } }
      assert_template 'sessions/new'
      assert_not flash.empty?
      get root_path
      assert flash.empty?
    end

    test "activated user login with valid information" do
        get login_path
        post login_path, params: { session: { email:    @activated_user.email,
                                              password: 'password' } }
        assert_redirected_to @activated_user
        follow_redirect!
        assert_template 'users/show'
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", logout_path
        assert_select "a[href=?]", user_path(@activated_user)
      end
  end
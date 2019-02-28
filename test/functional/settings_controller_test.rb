require File.expand_path('../../test_helper', __FILE__)

class SettingsControllerTest < Redmine::ControllerTest
  include Redmine::I18n

  fixtures :projects, :trackers, :issue_statuses, :issues

  plugin_fixtures :users, :user_preferences, :email_addresses,
                  :custom_fields, :custom_values

  def setup
    User.current = nil
    @request.session[:user_id] = 1 # admin
  end

  def teardown
    Setting.delete_all
    Setting.clear_cache
  end

  def test_index
    get :index
    assert_response :success

    assert_select 'select#settings_user_format' do
      assert_select 'option[value=username_affiliation_firstname_lastname]', :text => 'admin : [Affiliation] Redmine Admin'
      assert_select 'option[value=lastname_abbreviated_firstname]', :text => 'Admin(R)'
      assert_select 'option[value=affiliation_username_lastname_abbreviated_firstname]', :text => '[Affiliation] admin : Admin(R)'
    end
  end

end

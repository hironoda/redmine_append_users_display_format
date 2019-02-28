require File.expand_path('../../test_helper', __FILE__)

class ProjectsControllerTest < Redmine::ControllerTest
  include Redmine::I18n

  fixtures :projects, :versions, :roles,
           :issues, :journals, :journal_details,
           :trackers, :projects_trackers, :issue_statuses,
           :enabled_modules, :enumerations, :boards, :messages,
           :attachments, :time_entries,
           :wikis, :wiki_pages, :wiki_contents, :wiki_content_versions

  plugin_fixtures :users, :user_preferences, :email_addresses,
                  :custom_fields, :custom_values,
                  :groups_users,
                  :members, :member_roles

  def setup
    @request.session[:user_id] = nil
    Setting.default_language = 'en'
  end

  def test_uesr_formats_order
    User::USER_FORMATS.keys.each do |key|
      Setting.user_format = key.to_s
      puts  "user_format :  #{Setting.user_format}"
      get :show, :params => {
          :id => 'ecookbook'
        }
      assert_response :success
      assert_select '#header h1', :text => "eCookbook"
    end
  end

end

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RedmineAppendUsersDisplayFormatTest < ActiveSupport::TestCase
  plugin_fixtures :users, :custom_fields, :custom_values

  def setup
    Setting.plugin_redmine_append_users_display_format['string_before_login'] = '_'
  end

  def test_username
    u = User.find(2)
    assert u.login == 'jsmith' , 'The login of ID #{u.id} is not jsmith.'
    assert u.firstname == 'John' && u.lastname == 'Smith' , 'The user name of ID #{u.id} is not John Smith.'
  end

  def test_user_display_format_users_custom_field_name_of_affiliation_department
    Setting.plugin_redmine_append_users_display_format['users_custom_field_name_of_affiliation'] = s = 'Department'

    testcases = [
      {user_format: :firstname_lastname,       name: 'John Smith'},
      {user_format: :firstname_lastinitial,    name: 'John S.'},
      {user_format: :firstinitial_lastname,    name: 'J. Smith'},
      {user_format: :firstname,                name: 'John'},
      {user_format: :lastname_firstname,       name: 'Smith John'},
      {user_format: :lastnamefirstname,        name: 'SmithJohn'},
      {user_format: :lastname_comma_firstname, name: 'Smith, John'},
      {user_format: :lastname,                 name: 'Smith'},
      {user_format: :username,                 name: 'jsmith'},
      {user_format: :username_firstname_lastname,        name: '_jsmith : John Smith'},
      {user_format: :username_firstname_lastinitial,     name: '_jsmith : John S.'},
      {user_format: :username_firstinitial_lastname,     name: '_jsmith : J. Smith'},
      {user_format: :username_firstname,                 name: '_jsmith : John'},
      {user_format: :username_lastname_firstname,        name: '_jsmith : Smith John'},
      {user_format: :username_lastnamefirstname,         name: '_jsmith : SmithJohn'},
      {user_format: :username_lastname_coma_firstname,   name: '_jsmith : Smith, John'},
      {user_format: :username_lastname,                  name: '_jsmith : Smith'},
      {user_format: :affiliation_firstname_lastname,      name: '[Development] John Smith'},
      {user_format: :affiliation_firstname_lastinitial,   name: '[Development] John S.'},
      {user_format: :affiliation_firstinitial_lastname,   name: '[Development] J. Smith'},
      {user_format: :affiliation_firstname,               name: '[Development] John'},
      {user_format: :affiliation_lastname_firstname,      name: '[Development] Smith John'},
      {user_format: :affiliation_lastnamefirstname,       name: '[Development] SmithJohn'},
      {user_format: :affiliation_lastname_coma_firstname, name: '[Development] Smith, John'},
      {user_format: :affiliation_lastname,                name: '[Development] Smith'},
      {user_format: :affiliation_username,                name: '[Development] jsmith'},
      {user_format: :username_affiliation_firstname_lastname,      name: '_jsmith : [Development] John Smith'},
      {user_format: :username_affiliation_firstname_lastinitial,   name: '_jsmith : [Development] John S.'},
      {user_format: :username_affiliation_firstinitial_lastname,   name: '_jsmith : [Development] J. Smith'},
      {user_format: :username_affiliation_firstname,               name: '_jsmith : [Development] John'},
      {user_format: :username_affiliation_lastname_firstname,      name: '_jsmith : [Development] Smith John'},
      {user_format: :username_affiliation_lastnamefirstname,       name: '_jsmith : [Development] SmithJohn'},
      {user_format: :username_affiliation_lastname_coma_firstname, name: '_jsmith : [Development] Smith, John'},
      {user_format: :username_affiliation_lastname,                name: '_jsmith : [Development] Smith'},
      {user_format: :affiliation_username_firstname_lastname,      name: '[Development] _jsmith : John Smith'},
      {user_format: :affiliation_username_firstname_lastinitial,   name: '[Development] _jsmith : John S.'},
      {user_format: :affiliation_username_firstinitial_lastname,   name: '[Development] _jsmith : J. Smith'},
      {user_format: :affiliation_username_firstname,               name: '[Development] _jsmith : John'},
      {user_format: :affiliation_username_lastname_firstname,      name: '[Development] _jsmith : Smith John'},
      {user_format: :affiliation_username_lastnamefirstname,       name: '[Development] _jsmith : SmithJohn'},
      {user_format: :affiliation_username_lastname_coma_firstname, name: '[Development] _jsmith : Smith, John'},
      {user_format: :affiliation_username_lastname,                name: '[Development] _jsmith : Smith'},
      {user_format: :lastname_abbreviated_firstname,                      name: 'Smith'},
      {user_format: :username_lastname_abbreviated_firstname,             name: '_jsmith : Smith'},
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: '[Development] Smith'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_jsmith : [Development] Smith'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '[Development] _jsmith : Smith'},
    ]
    user_id = 2
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }

    testcases = [
      {user_format: :lastname_abbreviated_firstname,                      name: 'Thomson(D)'},
      {user_format: :username_lastname_abbreviated_firstname,             name: '_dthomson : Thomson(D)'},
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: '[Independent] Thomson(D)'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_dthomson : [Independent] Thomson(D)'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '[Independent] _dthomson : Thomson(D)'},
    ]
    user_id = 3
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }

    testcases = [
      {user_format: :lastname_abbreviated_firstname,                      name: 'Allan Nina'},
      {user_format: :username_lastname_abbreviated_firstname,             name: '_nallan2 : Allan Nina'},
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: '[Independent] Allan Nina'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_nallan2 : [Independent] Allan Nina'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '[Independent] _nallan2 : Allan Nina'},
    ]
    user_id = 4
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }
  end

  def test_user_display_format_users_custom_field_name_of_affiliation_company
    Setting.plugin_redmine_append_users_display_format['users_custom_field_name_of_affiliation'] = s = 'Company'

    testcases = [
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: 'Smith'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_jsmith : Smith'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '_jsmith : Smith'},
    ]
    user_id = 2
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }

    testcases = [
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: 'Thomson(D)'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_dthomson : Thomson(D)'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '_dthomson : Thomson(D)'},
    ]
    user_id = 3
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }

    testcases = [
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: 'Allan Nina'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_nallan2 : Allan Nina'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '_nallan2 : Allan Nina'},
    ]
    user_id = 4
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }
  end

  def test_user_display_format_users_custom_field_name_of_affiliation_blank
    Setting.plugin_redmine_append_users_display_format['users_custom_field_name_of_affiliation'] = s = ''

    testcases = [
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: 'Smith'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_jsmith : Smith'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '_jsmith : Smith'},
    ]
    user_id = 2
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }

    testcases = [
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: 'Thomson(D)'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_dthomson : Thomson(D)'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '_dthomson : Thomson(D)'},
    ]
    user_id = 3
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }

    testcases = [
      {user_format: :affiliation_lastname_abbreviated_firstname,          name: 'Allan Nina'},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, name: '_nallan2 : Allan Nina'},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, name: '_nallan2 : Allan Nina'},
    ]
    user_id = 4
    u = User.find(user_id)
    testcases.each{|t|
      assert_equal t[:name], u.name(t[:user_format]),
                   "user format : #{t[:user_format]}, user id : #{user_id}, custom field name : #{s}"
    }
  end

  def test_user_format_order
    order = {
      firstname_lastname:                   ['firstname', 'lastname', 'id'],
      firstname:                            ['firstname', 'id'],
      lastname_firstname:                   ['lastname', 'firstname', 'id'],
      lastname:                             ['lastname', 'id'],
      login:                                ['login', 'id'],
      login_firstname_lastname:             ['login', 'firstname', 'lastname', 'id'],
      login_firstname:                      ['login', 'firstname', 'id'],
      login_lastname_firstname:             ['login', 'lastname', 'firstname', 'id'],
      login_lastname:                       ['login', 'lastname', 'id'],
      affiliation_firstname_lastname:       ['affiliation', 'firstname', 'lastname', 'id'],
      affiliation_firstname:                ['affiliation', 'firstname', 'id'],
      affiliation_lastname_firstname:       ['affiliation', 'lastname', 'firstname', 'id'],
      affiliation_lastname:                 ['affiliation', 'lastname', 'id'],
      affiliation_login:                    ['affiliation', 'login', 'id'],
      login_affiliation_firstname_lastname: ['login', 'affiliation', 'firstname', 'lastname', 'id'],
      login_affiliation_firstname:          ['login', 'affiliation', 'firstname', 'id'],
      login_affiliation_lastname_firstname: ['login', 'affiliation', 'lastname', 'firstname', 'id'],
      login_affiliation_lastname:           ['login', 'affiliation', 'lastname', 'id'],
      affiliation_login_firstname_lastname: ['affiliation', 'login', 'firstname', 'lastname', 'id'],
      affiliation_login_firstname:          ['affiliation', 'login', 'firstname', 'id'],
      affiliation_login_lastname_firstname: ['affiliation', 'login', 'lastname', 'firstname', 'id'],
      affiliation_login_lastname:           ['affiliation', 'login', 'lastname', 'id'],
    }
    testcases = [
      {user_format: :firstname_lastname,       order: order[:firstname_lastname]},
      {user_format: :firstname_lastinitial,    order: order[:firstname_lastname]},
      {user_format: :firstinitial_lastname,    order: order[:firstname_lastname]},
      {user_format: :firstname,                order: order[:firstname]},
      {user_format: :lastname_firstname,       order: order[:lastname_firstname]},
      {user_format: :lastnamefirstname,        order: order[:lastname_firstname]},
      {user_format: :lastname_comma_firstname, order: order[:lastname_firstname]},
      {user_format: :lastname,                 order: order[:lastname]},
      {user_format: :username,                 order: order[:login]},
      {user_format: :username_firstname_lastname,      order: order[:login_firstname_lastname]},
      {user_format: :username_firstname_lastinitial,   order: order[:login_firstname_lastname]},
      {user_format: :username_firstinitial_lastname,   order: order[:login_firstname_lastname]},
      {user_format: :username_firstname,               order: order[:login_firstname]},
      {user_format: :username_lastname_firstname,      order: order[:login_lastname_firstname]},
      {user_format: :username_lastnamefirstname,       order: order[:login_lastname_firstname]},
      {user_format: :username_lastname_coma_firstname, order: order[:login_lastname_firstname]},
      {user_format: :username_lastname,                order: order[:login_lastname]},
      {user_format: :affiliation_firstname_lastname,      order: order[:affiliation_firstname_lastname]},
      {user_format: :affiliation_firstname_lastinitial,   order: order[:affiliation_firstname_lastname]},
      {user_format: :affiliation_firstinitial_lastname,   order: order[:affiliation_firstname_lastname]},
      {user_format: :affiliation_firstname,               order: order[:affiliation_firstname]},
      {user_format: :affiliation_lastname_firstname,      order: order[:affiliation_lastname_firstname]},
      {user_format: :affiliation_lastnamefirstname,       order: order[:affiliation_lastname_firstname]},
      {user_format: :affiliation_lastname_coma_firstname, order: order[:affiliation_lastname_firstname]},
      {user_format: :affiliation_lastname,                order: order[:affiliation_lastname]},
      {user_format: :affiliation_username,                order: order[:affiliation_login]},
      {user_format: :username_affiliation_firstname_lastname,      order: order[:login_affiliation_firstname_lastname]},
      {user_format: :username_affiliation_firstname_lastinitial,   order: order[:login_affiliation_firstname_lastname]},
      {user_format: :username_affiliation_firstinitial_lastname,   order: order[:login_affiliation_firstname_lastname]},
      {user_format: :username_affiliation_firstname,               order: order[:login_affiliation_firstname]},
      {user_format: :username_affiliation_lastname_firstname,      order: order[:login_affiliation_lastname_firstname]},
      {user_format: :username_affiliation_lastnamefirstname,       order: order[:login_affiliation_lastname_firstname]},
      {user_format: :username_affiliation_lastname_coma_firstname, order: order[:login_affiliation_lastname_firstname]},
      {user_format: :username_affiliation_lastname,                order: order[:login_affiliation_lastname]},
      {user_format: :affiliation_username_firstname_lastname,      order: order[:affiliation_login_firstname_lastname]},
      {user_format: :affiliation_username_firstname_lastinitial,   order: order[:affiliation_login_firstname_lastname]},
      {user_format: :affiliation_username_firstinitial_lastname,   order: order[:affiliation_login_firstname_lastname]},
      {user_format: :affiliation_username_firstname,               order: order[:affiliation_login_firstname]},
      {user_format: :affiliation_username_lastname_firstname,      order: order[:affiliation_login_lastname_firstname]},
      {user_format: :affiliation_username_lastnamefirstname,       order: order[:affiliation_login_lastname_firstname]},
      {user_format: :affiliation_username_lastname_coma_firstname, order: order[:affiliation_login_lastname_firstname]},
      {user_format: :affiliation_username_lastname,                order: order[:affiliation_login_lastname]},
      {user_format: :lastname_abbreviated_firstname,                      order: order[:lastname_firstname]},
      {user_format: :username_lastname_abbreviated_firstname,             order: order[:login_lastname_firstname]},
      {user_format: :affiliation_lastname_abbreviated_firstname,          order: order[:affiliation_lastname_firstname]},
      {user_format: :username_affiliation_lastname_abbreviated_firstname, order: order[:login_affiliation_lastname_firstname]},
      {user_format: :affiliation_username_lastname_abbreviated_firstname, order: order[:affiliation_login_lastname_firstname]},
    ]
    testcases.each{|t|
      assert_equal t[:order], User::USER_FORMATS[t[:user_format]][:order],
                   "order : #{t[:order]}"
    }
  end

end

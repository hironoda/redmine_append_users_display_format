require_dependency 'user'

module RedmineAppendUsersDisplayFormat::Patches::UserPatch

  def self.prepended(base)
    class << base
      self.prepend(ClassMethods)
    end
    base.class_eval do
      const_set :USER_FORMATS,
      {
        :username_firstname_lastname => {
            :string => '#{User.format_login(login)}#{firstname} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 101
          },
        :username_firstname_lastinitial => {
            :string => '#{User.format_login(login)}#{firstname} #{lastname.to_s.chars.first}.',
            :order => %w(login firstname lastname id),
            :setting_order => 102
          },
        :username_firstinitial_lastname => {
            :string => '#{User.format_login(login)}#{firstname.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 103
          },
        :username_firstname => {
            :string => '#{User.format_login(login)}#{firstname}',
            :order => %w(login firstname id),
            :setting_order => 104
          },
        :username_lastname_firstname => {
            :string => '#{User.format_login(login)}#{lastname} #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 105
          },
        :username_lastnamefirstname => {
            :string => '#{User.format_login(login)}#{lastname}#{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 106
          },
        :username_lastname_coma_firstname => {
            :string => '#{User.format_login(login)}#{lastname}, #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 107
          },
        :username_lastname => {
            :string => '#{User.format_login(login)}#{lastname}',
            :order => %w(login lastname id),
            :setting_order => 108
          },
        :affiliation_firstname_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{firstname} #{lastname}',
            :order => %w(firstname lastname id),
            :setting_order => 201
          },
        :affiliation_firstname_lastinitial => {
            :string => '#{User.format_affiliation(affiliation)}#{firstname} #{lastname.to_s.chars.first}.',
            :order => %w(firstname lastname id),
            :setting_order => 202
          },
        :affiliation_firstinitial_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{firstname.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{lastname}',
            :order => %w(firstname lastname id),
            :setting_order => 203
          },
        :affiliation_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{firstname}',
            :order => %w(firstname id),
            :setting_order => 204
          },
        :affiliation_lastname_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname} #{firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 205
          },
        :affiliation_lastnamefirstname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname}#{firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 206
          },
        :affiliation_lastname_coma_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname}, #{firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 207
          },
        :affiliation_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname}',
            :order => %w(lastname id),
            :setting_order => 208
          },
        :affiliation_username => {
            :string => '#{User.format_affiliation(affiliation)}#{login}',
            :order => %w(login id),
            :setting_order => 209
          },
        :username_affiliation_firstname_lastname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{firstname} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 301
          },
        :username_affiliation_firstname_lastinitial => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{firstname} #{lastname.to_s.chars.first}.',
            :order => %w(login firstname lastname id),
            :setting_order => 302
          },
        :username_affiliation_firstinitial_lastname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{firstname.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 303
          },
        :username_affiliation_firstname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{firstname}',
            :order => %w(login firstname id),
            :setting_order => 304
          },
        :username_affiliation_lastname_firstname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{lastname} #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 305
          },
        :username_affiliation_lastnamefirstname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{lastname}#{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 306
          },
        :username_affiliation_lastname_coma_firstname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{lastname}, #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 307
          },
        :username_affiliation_lastname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{lastname}',
            :order => %w(login lastname id),
            :setting_order => 308
          },
        :affiliation_username_firstname_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 401
          },
        :affiliation_username_firstname_lastinitial => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname} #{lastname.to_s.chars.first}.',
            :order => %w(login firstname lastname id),
            :setting_order => 402
          },
        :affiliation_username_firstinitial_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 403
          },
        :affiliation_username_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname}',
            :order => %w(login firstname id),
            :setting_order => 404
          },
        :affiliation_username_lastname_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname} #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 405
          },
        :affiliation_username_lastnamefirstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname}#{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 406
          },
        :affiliation_username_lastname_coma_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname}, #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 407
          },
        :affiliation_username_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname}',
            :order => %w(login lastname id),
            :setting_order => 408
          },
        :lastname_abbreviated_firstname => {
            :string => '#{lastname}#{abbreviated_firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 2001
          },
        :username_lastname_abbreviated_firstname => {
            :string => '#{User.format_login(login)}#{lastname}#{abbreviated_firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 2002
          },
        :affiliation_lastname_abbreviated_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname}#{abbreviated_firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 2003
          },
        :username_affiliation_lastname_abbreviated_firstname => {
            :string => '#{User.format_login(login)}#{User.format_affiliation(affiliation)}#{lastname}#{abbreviated_firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 2004
          },
        :affiliation_username_lastname_abbreviated_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname}#{abbreviated_firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 2005
          },
      }.merge(remove_const :USER_FORMATS)
    end
  end

  module ClassMethods

    def users_custom_field_name_of_affiliation
      Setting.plugin_redmine_append_users_display_format['users_custom_field_name_of_affiliation'].to_s
    end

    def independent_affiliation
      Setting.plugin_redmine_append_users_display_format['independent_affiliation'].to_s
    end

    def format_login(login)
      before = Setting.plugin_redmine_append_users_display_format['string_before_login'].to_s
      after  = Setting.plugin_redmine_append_users_display_format['string_after_login'].to_s
      append_users_display_format_join_before_after_strings login, before, after
    end

    def format_affiliation(affiliation)
      before = Setting.plugin_redmine_append_users_display_format['string_before_affiliation'].to_s
      after  = Setting.plugin_redmine_append_users_display_format['string_after_affiliation'].to_s
      append_users_display_format_join_before_after_strings affiliation, before, after
    end

    def append_users_display_format_join_before_after_strings(string, before, after)
      s = String.new
      return s if not string or string.empty?
      after = ' ' if after.empty?
      s << before << string.to_s << after
      s
    end

  end

  def reload(*args)
    @affiliation = nil
    @exist_affiliation_users_custom_field = nil
    @abbreviated_firstname = nil
    @force_abbreviated_firstname = nil
    @force_affiliation = nil
    super(*args)
  end

  def affiliation
    return @affiliation if @affiliation
    @affiliation = get_affiliation
    @affiliation = I18n.t :redmine_append_users_display_format_label_affiliation if @force_affiliation && @affiliation.empty?
    @affiliation
  end

  def get_affiliation
    return '' unless exist_affiliation_users_custom_field
    custom_values = CustomValue.
                     joins(:custom_field).
                     where(["#{CustomValue.table_name}.customized_id = ?", self.id]).
                     where(["#{CustomValue.table_name}.customized_type = ?", 'Principal']).
                     where(["#{CustomField.table_name}.type = ?", 'UserCustomField']).
                     where(["#{CustomField.table_name}.name = ?", self.class.users_custom_field_name_of_affiliation])
    return self.class.independent_affiliation if custom_values.blank? or custom_values.length != 1
    custom_value = custom_values.first
    return self.class.independent_affiliation if custom_value[:value].to_s.empty?
    return custom_value[:value]
  end

  def exist_affiliation_users_custom_field
    tbl_name = UserCustomField.table_name
    type = 'UserCustomField'
    query = [ "SELECT COUNT(*) FROM #{tbl_name} WHERE #{tbl_name}.name = :name AND #{tbl_name}.type IN (:type)",
              name: self.class.users_custom_field_name_of_affiliation,
              type: type ]
    @exist_affiliation_users_custom_field ||=
      ! self.class.users_custom_field_name_of_affiliation.empty? &&
      UserCustomField.count_by_sql(query) == 1
  end

  private :get_affiliation, :exist_affiliation_users_custom_field

  # 名前の略称
  # * Redmineに同じ姓のユーザーが存在しない場合、空白を返す
  # * Redmineに同じ姓のユーザーが存在する場合
  #   * 名前の1文字目が同じユーザーが存在しない場合、「名前の前の文字列 + 名前の1文字目 + 名前の後の文字列 」を返す
  #   * 名前の1文字目が同じユーザーが存在する場合、諦めて「名前」を返す
  def abbreviated_firstname
    return @abbreviated_firstname if @abbreviated_firstname
    return @abbreviated_firstname = first_character_of_firstname if @force_abbreviated_firstname
    return @abbreviated_firstname = self[:firstname] if self[:lastname].empty?
    return @abbreviated_firstname = '' if self[:firstname].empty?
    u = User
    tbl_name = u.table_name
    type = 'User'
    query = [ "SELECT COUNT(*) FROM #{tbl_name} WHERE #{tbl_name}.lastname = :lastname AND #{tbl_name}.type IN (:type)",
              lastname: self[:lastname],
              type: type ]
    return @abbreviated_firstname = '' if u.count_by_sql(query) == 1
    sql = ''
    sql << "SELECT COUNT(*) FROM #{tbl_name} WHERE #{tbl_name}.lastname = :lastname AND #{tbl_name}.firstname LIKE :firstname"
    sql << " AND #{tbl_name}.type IN (:type)"
    query = [ sql, 
              lastname:  self[:lastname],
              firstname: "#{self[:firstname][0]}%",
              type: type ]
    return @abbreviated_firstname = first_character_of_firstname if u.count_by_sql(query) == 1
    @abbreviated_firstname = " #{self[:firstname]}"
  end

  def first_character_of_firstname
    before = Setting.plugin_redmine_append_users_display_format['string_before_abbreviated_firstname'].to_s
    after  = Setting.plugin_redmine_append_users_display_format['string_after_abbreviated_firstname'].to_s
    self.class.append_users_display_format_join_before_after_strings self[:firstname][0], before, after
  end

  private :first_character_of_firstname

  def name(formatter = nil)
    c = caller[0].to_s.split(':')
    @force_abbreviated_firstname = 
      (c.length == 3 && File.basename(c[0]) == 'settings_controller.rb' && c[2].include?('edit'))
    @force_affiliation = @force_abbreviated_firstname
    super(formatter).strip
  end

end

User.prepend RedmineAppendUsersDisplayFormat::Patches::UserPatch

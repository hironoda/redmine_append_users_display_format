require_dependency 'user'

module RedmineAppendUsersDisplayFormat::Patches::UserPatch

  def self.prepended(base)
    base.extend(ClassMethods)
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
            :setting_order => 102
          },
        :username_firstname => {
            :string => '#{User.format_login(login)}#{firstname}',
            :order => %w(login firstname id),
            :setting_order => 103
          },
        :username_lastname_firstname => {
            :string => '#{User.format_login(login)}#{lastname} #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 104
          },
        :username_lastname_coma_firstname => {
            :string => '#{User.format_login(login)}#{lastname}, #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 105
          },
        :username_lastname => {
            :string => '#{User.format_login(login)}#{lastname}',
            :order => %w(login lastname id),
            :setting_order => 106
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
            :setting_order => 202
          },
        :affiliation_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{firstname}',
            :order => %w(firstname id),
            :setting_order => 203
          },
        :affiliation_lastname_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname} #{firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 204
          },
        :affiliation_lastname_coma_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname}, #{firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 205
          },
        :affiliation_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{lastname}',
            :order => %w(lastname id),
            :setting_order => 206
          },
        :affiliation_username => {
            :string => '#{User.format_affiliation(affiliation)}#{login}',
            :order => %w(login id),
            :setting_order => 207
          },
        :affiliation_username_firstname_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 301
          },
        :affiliation_username_firstname_lastinitial => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname} #{lastname.to_s.chars.first}.',
            :order => %w(login firstname lastname id),
            :setting_order => 302
          },
        :affiliation_username_firstinitial_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 302
          },
        :affiliation_username_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{firstname}',
            :order => %w(login firstname id),
            :setting_order => 303
          },
        :affiliation_username_lastname_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname} #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 304
          },
        :affiliation_username_lastname_coma_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname}, #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 305
          },
        :affiliation_username_lastname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname}',
            :order => %w(login lastname id),
            :setting_order => 306
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
        :affiliation_username_lastname_abbreviated_firstname => {
            :string => '#{User.format_affiliation(affiliation)}#{User.format_login(login)}#{lastname}#{abbreviated_firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 2004
          },
      }.merge(remove_const :USER_FORMATS)
    end
  end

  module ClassMethods

    def users_custom_fields_name_of_affiliation
      Setting.plugin_redmine_append_users_display_format['users_custom_fields_name_of_affiliation'].to_s
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

  def affiliation
    return @affiliation if @affiliation
    @affiliation = nil
    return '' unless exist_affiliation_users_custom_field
    custom_values = CustomValue.
                     joins(:custom_field).
                     where(["#{CustomValue.table_name}.customized_id = ?", self.id]).
                     where(["#{CustomValue.table_name}.customized_type = ?", 'Principal']).
                     where(["#{CustomField.table_name}.type = ?", 'UserCustomField']).
                     where(["#{CustomField.table_name}.name = ?", self.class.users_custom_fields_name_of_affiliation])
    custom_value = custom_values.first
    return self.class.independent_affiliation if custom_values.length != 1 or custom_value[:value].to_s.empty?
    @affiliation = custom_value[:value]
  end

  def exist_affiliation_users_custom_field
    @exist_affiliation_users_custom_field ||=
      ! self.class.users_custom_fields_name_of_affiliation.empty? &&
      UserCustomField.where(name: self.class.users_custom_fields_name_of_affiliation).count == 1
  end

  private :exist_affiliation_users_custom_field

  # 名前の略称
  # * Redmineに同じ姓のユーザーが存在しない場合、空白を返す
  # * Redmineに同じ姓のユーザーが存在する場合
  #   * 名前の1文字目が同じユーザーが存在しない場合、「名前の前の文字列 + 名前の1文字目 + 名前の後の文字列 」を返す
  #   * 名前の1文字目が同じユーザーが存在する場合、諦めて「名前」を返す
  def abbreviated_firstname
    return @abbreviated_firstname if @abbreviated_firstname
    u = User
    return @abbreviated_firstname = '' if u.where(lastname: self[:lastname]).count == 1
    before = Setting.plugin_redmine_append_users_display_format['string_before_abbreviated_firstname'].to_s
    after  = Setting.plugin_redmine_append_users_display_format['string_after_abbreviated_firstname'].to_s
    return @abbreviated_firstname = "#{before}#{self[:firstname][0]}#{after}" if
      u.
      where(lastname: self[:lastname]).
      where(u.arel_table[:firstname].matches("#{self[:firstname][0]}%")).count == 1
    @abbreviated_firstname = " #{self[:firstname]}"
  end

end

User.prepend RedmineAppendUsersDisplayFormat::Patches::UserPatch

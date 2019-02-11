require_dependency 'user'

module RedmineAppendUsersDisplayFormat::Patches::UserPatch

  def self.included(base)

    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
 
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
        :department_firstname_lastname => {
            :string => '#{User.format_department(department)}#{firstname} #{lastname}',
            :order => %w(firstname lastname id),
            :setting_order => 201
          },
        :department_firstname_lastinitial => {
            :string => '#{User.format_department(department)}#{firstname} #{lastname.to_s.chars.first}.',
            :order => %w(firstname lastname id),
            :setting_order => 202
          },
        :department_firstinitial_lastname => {
            :string => '#{User.format_department(department)}#{firstname.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{lastname}',
            :order => %w(firstname lastname id),
            :setting_order => 202
          },
        :department_firstname => {
            :string => '#{User.format_department(department)}#{firstname}',
            :order => %w(firstname id),
            :setting_order => 203
          },
        :department_lastname_firstname => {
            :string => '#{User.format_department(department)}#{lastname} #{firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 204
          },
        :department_lastname_coma_firstname => {
            :string => '#{User.format_department(department)}#{lastname}, #{firstname}',
            :order => %w(lastname firstname id),
            :setting_order => 205
          },
        :department_lastname => {
            :string => '#{User.format_department(department)}#{lastname}',
            :order => %w(lastname id),
            :setting_order => 206
          },
        :department_username => {
            :string => '#{User.format_department(department)}#{login}',
            :order => %w(login id),
            :setting_order => 207
          },
        :department_username_firstname_lastname => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{firstname} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 301
          },
        :department_username_firstname_lastinitial => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{firstname} #{lastname.to_s.chars.first}.',
            :order => %w(login firstname lastname id),
            :setting_order => 302
          },
        :department_username_firstinitial_lastname => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{firstname.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{lastname}',
            :order => %w(login firstname lastname id),
            :setting_order => 302
          },
        :department_username_firstname => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{firstname}',
            :order => %w(login firstname id),
            :setting_order => 303
          },
        :department_username_lastname_firstname => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{lastname} #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 304
          },
        :department_username_lastname_coma_firstname => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{lastname}, #{firstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 305
          },
        :department_username_lastname => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{lastname}',
            :order => %w(login lastname id),
            :setting_order => 306
          },
        :lastname_abbreviatedfirstname => {
            :string => '#{lastname}#{abbreviatedfirstname}',
            :order => %w(lastname firstname id),
            :setting_order => 2001
          },
        :username_lastname_abbreviatedfirstname => {
            :string => '#{User.format_login(login)}#{lastname}#{abbreviatedfirstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 2002
          },
        :department_lastname_abbreviatedfirstname => {
            :string => '#{User.format_department(department)}#{lastname}#{abbreviatedfirstname}',
            :order => %w(lastname firstname id),
            :setting_order => 2003
          },
        :department_username_lastname_abbreviatedfirstname => {
            :string => '#{User.format_department(department)}#{User.format_login(login)}#{lastname}#{abbreviatedfirstname}',
            :order => %w(login lastname firstname id),
            :setting_order => 2004
          },
      }.merge(remove_const :USER_FORMATS)

      private :exist_department_users_custom_field

    end

  end

  module ClassMethods

    def users_custom_fields_name_of_department
      Setting.plugin_redmine_append_users_display_format[:users_custom_fields_name_of_department].to_s
    end

    def independent_indication
      Setting.plugin_redmine_append_users_display_format[:independent_indication].to_s
    end

    def format_login(login)
      before = Setting.plugin_redmine_append_users_display_format[:string_before_login].to_s
      after  = Setting.plugin_redmine_append_users_display_format[:string_after_login].to_s
      format_login_department login, before, after
    end

    def format_department(department)
      before = Setting.plugin_redmine_append_users_display_format[:string_before_department].to_s
      after  = Setting.plugin_redmine_append_users_display_format[:string_after_department].to_s
      format_login_department department, before, after
    end

    def format_login_department(string, before, after)
      s = String.new
      return s if not string or string.empty?
      after = ' ' if after.empty?
      s << before << string.to_s << after
      s
    end

  end

  module InstanceMethods

    def department
      return @department if @department
      @department = nil
      return '' unless exist_department_users_custom_field
      custom_values = CustomValue.
                       joins(:custom_field).
                       where(["#{CustomValue.table_name}.customized_id = ?", self.id]).
                       where(["#{CustomValue.table_name}.customized_type = ?", 'Principal']).
                       where(["#{CustomField.table_name}.type = ?", 'UserCustomField']).
                       where(["#{CustomField.table_name}.name = ?", self.class.users_custom_fields_name_of_department])
      custom_value = custom_values.first
      return self.class.independent_indication if custom_values.length != 1 or custom_value[:value].to_s.empty?
      @department = custom_value[:value]
    end

    def exist_department_users_custom_field
      @exist_department_users_custom_field ||=
        ! self.class.users_custom_fields_name_of_department.empty? &&
        UserCustomField.where(name: self.class.users_custom_fields_name_of_department).count == 1
    end

    # 名前の略称
    # * Redmineに同じ姓のユーザーが存在しない場合空白を返す
    # * Redmineに同じ姓のユーザーが存在する場合
    #   * 名前の1文字目が同じユーザーが存在しない場合、「'(' + 名前の1文字目 + ')' 」を返す
    #   * 名前の1文字目が同じユーザーが存在する場合、諦めて名前を返す
    def abbreviatedfirstname
      return @abbreviatedfirstname if @abbreviatedfirstname
      u = User
      return @abbreviatedfirstname = '' if u.where(lastname: self[:lastname]).count == 1
      return @abbreviatedfirstname = " (#{self[:firstname][0]})" if u.
        where(lastname: self[:lastname]).
        where(u.arel_table[:firstname].matches("#{self[:firstname][0]}%")).count == 1
      @abbreviatedfirstname = " #{self[:firstname]}"
    end

  end

end

User.send :include, RedmineAppendUsersDisplayFormat::Patches::UserPatch

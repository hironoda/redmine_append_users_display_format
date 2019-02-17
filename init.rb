require_dependency 'redmine_append_users_display_format/patches/user_patch'

Redmine::Plugin.register :redmine_append_users_display_format do
  name 'Redmine Append Users Display Format plugin'
  author 'NODA Hiroyuki'
  description 'Append Users Display Format.'
  version '0.0.2'
  url 'https://github.com/hironoda/redmine_append_users_display_format'
#  author_url 'http://example.com/about'

  settings :default => {
    'users_custom_fields_name_of_affiliation' => 'affiliation',
    'string_before_affiliation'               => '[',
    'string_after_affiliation'                => '] ',
    'string_before_login'                     => '',
    'string_after_login'                      => ' : ',
    'string_before_abbreviated_firstname'     => ' (',
    'string_after_abbreviated_firstname'      => ')',
    'independent_affiliation'                 => 'Independent'
  }, :partial => 'settings/redmine_append_users_display_format_settings'
end

require 'redmine'

require_dependency 'custom_fields_helper_patch'
require_dependency 'issues_helper_patch'

Redmine::Plugin.register :custom_fields_i18n do
  name 'Custom Fields I18n plugin'
  author 'General Failure'
  description 'Internalization for Redmine custom fields'
  version '0.0.3'
  url 'https://github.com/gf59ru/RedmineCustomFieldsI18n'
  author_url 'https://github.com/gf59ru'
end

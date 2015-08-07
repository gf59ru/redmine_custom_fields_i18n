require 'redmine'

require_dependency 'custom_fields_helper_patch'

Redmine::Plugin.register :custom_fields_i18n do
  name 'Custom Fields I18n plugin'
  author 'General Failure'
  description 'Internalization for Redmine custom fields'
  version '0.0.1'
  url ''
  author_url ''
end

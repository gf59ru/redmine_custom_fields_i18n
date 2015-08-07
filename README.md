# RedmineCustomFieldsI18n
Plugin for Redmine CustomFields Internalization

# What is it
Redmine is flexible system that allows many things, including custom fields
But they are can not be localized - they have name and description in one language
In Redmine views custom fields shows name in label and description in title
My plugin replace custom field labels and show translations from localization files

# How to
Add necessary translations to %plugin_or_root_folder%/config/locales/%locale%.yml:
```
en:
  custom_field_name: "MY CUSTOM FIELD LOCALIZED DESCRIPTION"
```
That translations will be used for custom field labels show
If translation will be missed (in this case usually ```translation missing: locale.string``` message shows), custom field description will be used

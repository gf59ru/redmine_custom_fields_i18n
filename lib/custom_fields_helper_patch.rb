require_dependency 'custom_fields_helper'

module CustomFieldsHelperPatch

  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      alias_method :custom_field_label_tag_without_i18n, :custom_field_label_tag
      alias_method :custom_field_label_tag, :custom_field_label_tag_with_i18n
    end

  end

  module InstanceMethods

    def custom_field_label_tag_with_i18n(name, custom_value, options={})
      required = options[:required] || custom_value.custom_field.is_required?
      custom_field_name = custom_value.custom_field.name
      l_name = l(custom_field_name)
      if l_name.index('translation missing:') == 0 && l_name.index(custom_field_name) == l_name.length - custom_field_name.length
        l_name = custom_value.custom_field.description.presence
      end
      content = content_tag 'span', l_name

      content_tag 'label', content +
                             (required ? " <span class=\"required\">*</span>".html_safe : ''),
                  :for => "#{name}_custom_field_values_#{custom_value.custom_field.id}"
    end

  end

end

CustomFieldsHelper.send :include, CustomFieldsHelperPatch

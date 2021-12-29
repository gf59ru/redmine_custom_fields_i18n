require_dependency 'issues_helper'

module IssuesHelperPatch

  def self.included(base) # :nodoc:
    # base.send(:extend, ClassMethods)
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      alias_method :render_half_width_custom_fields_rows_without_patch, :render_half_width_custom_fields_rows
      alias_method :render_half_width_custom_fields_rows, :render_half_width_custom_fields_rows_with_patch
    end
  end

  module InstanceMethods

    def render_half_width_custom_fields_rows_with_patch(issue, fields = []) # fields is optional argument defining list of custom fields for view (default all)
      values = issue.visible_custom_field_values
      return if values.empty?
      unless fields.nil? || fields.empty?
        values.select! { |value| fields.include? value.custom_field.name }
      end
      ordered_values = []
      half = (values.size / 2.0).ceil
      half.times do |i|
        ordered_values << values[i]
        ordered_values << values[i + half]
      end
      s = "<tr>\n"
      n = 0
      ordered_values.compact.each do |value|
        custom_field_name = value.custom_field.name
        l_name = l(custom_field_name)
        if l_name.index('translation missing:') == 0 && l_name.index(custom_field_name) == l_name.length - custom_field_name.length
          l_name = value.custom_field.description.presence
        end

        css = "cf_#{value.custom_field.id}"
        s << "</tr>\n<tr>\n" if n > 0 && (n % 2) == 0
        s << "\t<th class=\"#{css}\">#{ h(l_name) }:</th><td class=\"#{css}\">#{ h(show_value(value)) }</td>\n"
        n += 1
      end
      s << "</tr>\n"
      s.html_safe
    end

  end

end

IssuesHelper.send :include, IssuesHelperPatch

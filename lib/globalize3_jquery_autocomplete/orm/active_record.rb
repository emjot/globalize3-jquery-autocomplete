# Patch for rails3-jquery-autocomplete to work with globalize3.
# (based on rails3-jquery-autocomplete 1.0.11)
module Globalize3JQueryAutocomplete
  module Orm
    module ActiveRecord

      def self.included(base)
        base.send :include, InstanceMethods
        base.send :alias_method_chain, :get_autocomplete_items, :globalize3
      end

      module InstanceMethods

        def get_autocomplete_items_with_globalize3(parameters)
          model            = parameters[:model]
          translated_model = find_globalized_column_class_for(model, parameters[:method])
          globalized       = translated_model.present?
          term    = parameters[:term]
          method  = parameters[:method]
          options = parameters[:options]
          scopes  = Array(options[:scopes])
          where   = options[:where]
          limit   = get_autocomplete_limit(options)
          order   = get_autocomplete_order(method, options, (globalized ? translated_model : model))

          items = model.scoped

          scopes.each { |scope| items = items.send(scope) } unless scopes.empty?

          items = items.select(get_autocomplete_select_clause(model, method, options)) unless options[:full_model]

          if globalized
            items.includes(translated_model)
            items = items.where(get_autocomplete_where_clause(translated_model, term, method, options)).
                limit(limit).order(order).uniq
          else
            items = items.where(get_autocomplete_where_clause(model, term, method, options)).
                limit(limit).order(order).uniq
          end

          items = items.where(where) unless where.blank?

          items
        end

        # If the attribute of the record is globalized, returns the translation class; otherwise, returns nil.
        def find_globalized_column_class_for(record, attribute)
          if record.respond_to?(:translation_class) && record.translated_attribute_names.include?(attribute)
            record.translation_class
          else
            nil
          end
        end
      end

    end
  end
end
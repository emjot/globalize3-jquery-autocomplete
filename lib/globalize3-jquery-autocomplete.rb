require "globalize3_jquery_autocomplete/version"
require "globalize3_jquery_autocomplete/orm/active_record"

require "rails/all"
require "globalize3"
require "rails3-jquery-autocomplete"

ActiveSupport.on_load :action_controller do
  if defined?(Mongoid::Document) || defined?(MongoMapper::Document)
    if Rails.logger.try(:error?)
      Rails.logger.error("globalize3-jquery-autocomplete only supports ActiveRecord (not Mongoid / MongoMapper)")
    end
  else
    ActionController::Base.send(:include, Globalize3JQueryAutocomplete::Orm::ActiveRecord)
  end
end

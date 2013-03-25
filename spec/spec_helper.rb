require File.expand_path(File.join(File.dirname(__FILE__), '../lib/globalize3-jquery-autocomplete'))

require 'fileutils'
require 'logger'
require 'database_cleaner'

RSpec.configure do |config|

  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation

    tmpdir = File.join(File.dirname(__FILE__), "../tmp")
    FileUtils.mkdir(tmpdir) unless File.exist?(tmpdir)
    log = File.expand_path(File.join(tmpdir, "globalize3_test.log"))
    FileUtils.touch(log) unless File.exists?(log)
    ActiveRecord::Base.logger = Logger.new(log)
    ActiveRecord::LogSubscriber.attach_to(:active_record)

    ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
    require File.expand_path('../data/schema', __FILE__)
    require File.expand_path('../data/models', __FILE__)

    I18n.locale = I18n.default_locale = :en
    Globalize.locale = nil
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

class Rails3JQueryAutocomplete::Orm::ActiveRecordTestHelper
  include Rails3JQueryAutocomplete::Autocomplete
  include Globalize3JQueryAutocomplete::Orm::ActiveRecord
end

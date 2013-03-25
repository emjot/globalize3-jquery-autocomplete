class Post < ActiveRecord::Base
  translates :title, :content, :published, :published_at
end

class Untranslated < ActiveRecord::Base
end


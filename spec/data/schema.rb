ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :posts, :force => true do |t|
    t.integer    :rating
  end

  create_table :post_translations, :force => true do |t|
    t.string     :locale
    t.references :post
    t.string     :title
    t.text       :content
    t.boolean    :published
    t.datetime   :published_at
  end

  create_table :untranslateds, :force => true do |t|
    t.string :name
    t.integer :rating
  end

end
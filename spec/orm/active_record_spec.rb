# coding: utf-8
require 'spec_helper'

describe 'Globalize3JQueryAutocomplete::Orm::ActiveRecord' do
  let(:helper) do
    Rails3JQueryAutocomplete::Orm::ActiveRecordTestHelper.new()
  end

  describe "#get_autocomplete_order" do
    describe 'order is specified' do
      it 'should returns that order option' do
        helper.get_autocomplete_order(:field, {:order => 'field ASC'}).should == "field ASC"
      end
    end
  
    describe 'no order is specified' do
      it 'should return the order clause by the field ASC' do
        helper.get_autocomplete_order(:field, {}).should == "field ASC"
      end
  
      describe 'a different model is specified' do
        it 'should return the order clause by the table_name.field ASC' do
          model = double("model")
          model.stub(:table_name => 'table_name')
          helper.get_autocomplete_order(:field, {}, model).should == "table_name.field ASC"
        end
      end
    end
  end
  
  describe '#get_autocomplete_items' do
    before(:each) do
      # create 'en' posts
      @matching_en_posts = %w(query3 QUERY query2).collect { |title| Post.create!(:title => title, :untranslated => title) }
      other_en_posts = %w(myquery Foo bar).collect { |title| Post.create!(:title => title, :untranslated => title) }
      Globalize.with_locale(:de) do
        # add a 'de' translation to the first 'en' post
        @matching_en_de_posts = [@matching_en_posts.first]
        @matching_en_de_posts.first.update_attributes!(:title => 'query_de')

        @matching_de_posts = @matching_en_de_posts.dup

        # create 'de' posts
        @matching_de_posts += %w(queryde QUERYde2).collect { |title| Post.create!(:title => title, :untranslated => title) }
        other_de_posts = %w(myqueryde DE).collect { |title| Post.create!(:title => title, :untranslated => title) }
      end

      @matching_posts = (@matching_de_posts + @matching_en_posts).uniq

      @options = {
        :model => Post,
        :term => 'query',
        :options => {}
      }
    end

    it 'should work with an untranslated column (untranslated model)' do
      matching = Untranslated.create!(:name => 'queryme')
      Untranslated.create!(:name => 'foo')
      @options.merge!(:model => Untranslated, :method => :name)

      helper.get_autocomplete_items(@options).should == [matching]
    end

    it 'should work with an untranslated column (translated model)' do
      @options.merge!(:method => :untranslated)
      helper.get_autocomplete_items(@options).should == @matching_posts.sort_by(&:untranslated)
    end

    it 'should work with a translated column' do
      @options.merge!(:method => :title)
      helper.get_autocomplete_items(@options).should == @matching_en_posts.sort_by(&:title)
    end

  end
  
  describe '#get_autocomplete_select_clause' do
    before(:each) do
      @model = double("model")
      @model.stub(:table_name => 'table_name', :primary_key => 'id')
    end
  
    it 'should create a select clause' do
      helper.get_autocomplete_select_clause(@model, @model, :method, {}).should ==
          ["table_name.id", "table_name.method"]
    end
  
    describe 'with extra options' do
      it 'should return those extra fields on the clause' do
        options = {:extra_data => ['table_name.created_at']}
  
        helper.get_autocomplete_select_clause(@model, @model, :method, options).should ==
            ["table_name.id", "table_name.method", "table_name.created_at"]
      end
    end
  end
  
  describe '#get_autocomplete_where_clause' do
    before(:each) do
      @model = double("model")
      @model.stub(:table_name => 'table_name')
  
      @term = 'query'
      @options = {}
      @method = :method
    end
  
    describe 'Not Postgres' do
      it 'should return options for where' do
        helper.stub(:postgres?).with(@model).and_return(false)
        helper.get_autocomplete_where_clause(@model, @term, @method, @options).should ==
            ["LOWER(table_name.method) LIKE ?", "query%"]
      end
    end
  
    describe 'Postgres' do
      it 'should return options for where with ILIKE' do
        helper.stub(:postgres?).with(@model).and_return(true)
        helper.get_autocomplete_where_clause(@model, @term, @method, @options).should ==
            ["LOWER(table_name.method) ILIKE ?", "query%"]
      end
    end
  
    describe 'full search' do
      it 'should return options for where with the term sourrounded by %%' do
        helper.stub(:postgres?).with(@model).and_return(false)
        @options[:full] = true
        helper.get_autocomplete_where_clause(@model, @term, @method, @options).should ==
            ["LOWER(table_name.method) LIKE ?", "%query%"]
      end
    end
  end
  
  describe '#postgres?' do
    before(:each) do
      @model = double("model")
    end
  
    describe 'the connection class is not postgres' do
      before(:each) do
        @model.stub(:connection).and_return { double("something") }
      end
  
      it 'should return nil if the connection class matches PostgreSQLAdapter' do
        helper.postgres?(@model).should be_nil
      end
    end
  
    describe 'the connection class matches PostgreSQLAdapter' do
      before(:each) do
        class PostgreSQLAdapter; end
        @model.stub(:connection => PostgreSQLAdapter.new)
      end
  
      it 'should return true' do
        helper.postgres?(@model).should be_true
      end
    end
  end

end

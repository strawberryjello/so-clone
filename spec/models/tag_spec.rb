require 'rails_helper'

RSpec.describe Tag do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
  
  describe 'parsing' do
    it 'should create new tags' do
      str = 'single'
      
      tags = Tag.parse_tag_string str

      tag = Tag.find_by(:name => str)
      expect(tag.name).to eq(str)

      expect(tags.size).to eq(1)
      expect(tags.first.name).to eq(str)
    end

    it 'should not duplicate existing tags' do
      str = 'existing'
      tag = Tag.new(:name => str)

      tags = Tag.parse_tag_string str
      
      expect(Tag.count).to eq(1)

      expect(tags.size).to eq(1)
      expect(tags.first.name).to eq(str)
    end

    it 'should handle both new and existing tags in a string' do
      str = 'new, existing'
      tag = Tag.new(:name => 'existing')

      tags = Tag.parse_tag_string str

      expect(Tag.count).to eq(2)

      expect(tags.size).to eq(2)
      expect(tags.first.name).to eq('new')
      expect(tags.last.name).to eq('existing')
    end

    it 'should sanitize tags' do
      str = " new,<script> alert('alert');\n</script> ,existing"
      tag = Tag.new(:name => 'existing')
      
      tags = Tag.parse_tag_string str

      expect(Tag.count).to eq(2)

      expect(tags.size).to eq(2)
      expect(tags.first.name).to eq('new')
      expect(tags.last.name).to eq('existing')
    end
  end
end

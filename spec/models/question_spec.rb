require 'rails_helper'

RSpec.describe Question do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:text) }
  end
  
  describe 'tagging' do
    it 'should add new tags to a question' do
      t1 = Tag.new(:name => 't1')
      question = Question.new
      
      question.add_tags [t1]

      expect(question.tags).to include(t1)
    end
  end
end

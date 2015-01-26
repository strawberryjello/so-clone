require 'rails_helper'

RSpec.describe Question do
  context 'validations' do
    it 'should check presence of title' do
      question = Question.new(:text => 'text')
      expect(question.save).to be false
    end
    
    it 'should check presence of text' do
      question = Question.new(:title => 'title')
      expect(question.save).to be false
    end
  end
  
  context 'tagging' do
    it 'should add new tags to a question' do
      t1 = Tag.new(:name => 't1')
      question = Question.new
      
      question.add_tags [t1]

      expect(question.tags).to include(t1)
    end
  end
end

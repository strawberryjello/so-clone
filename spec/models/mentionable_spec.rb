require 'rails_helper'

RSpec.describe Mentionable do
  describe 'user mention parsing' do
    it 'should create a user profile link' do
      text = "<p>hey @user1!</p>"
      
      user1 = User.new(:id => 1, :login => 'user1')
      allow(User).to receive(:find_by).and_return(user1)
      
      host = Object.new.extend(Mentionable)
      parsed = host.parse_mentions text

      expected = "<p>hey <a href='/users/1/profile'>user1</a>!</p>"
      expect(parsed).to eq(expected)
    end

    it 'should create multiple user profile links' do
      text = "<p>hey @user1 @user2!</p>"

      user1 = User.new(:id => 1, :login => 'user1')
      user2 = User.new(:id => 2, :login => 'user2')
      allow(User).to receive(:find_by).and_return(user1, user2)
      
      host = Object.new.extend(Mentionable)
      parsed = host.parse_mentions text

      expected = "<p>hey <a href='/users/1/profile'>user1</a> <a href='/users/2/profile'>user2</a>!</p>"
      expect(parsed).to eq(expected)
    end
    
    it 'should do nothing when user does not exist' do
      text = "<p>hey @user1!</p>"

      host = Object.new.extend(Mentionable)
      parsed = host.parse_mentions text

      expect(parsed).to eq(text)
    end

    it 'should do nothing when there are no mentions' do
      text = "<p>hey @!</p>"

      host = Object.new.extend(Mentionable)
      parsed = host.parse_mentions text

      expect(parsed).to eq(text)
    end

  end
end

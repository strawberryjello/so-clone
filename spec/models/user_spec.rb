require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:login) }
    #it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it { is_expected.to validate_presence_of(:email) }

    # the ff syntax is deprecated, but validate_length_of doesn't work
    it { is_expected.to ensure_length_of(:password).is_at_least(8).is_at_most(40) }

    it { is_expected.to validate_uniqueness_of(:login) }
    it { is_expected.to validate_uniqueness_of(:email) }
    
    it { is_expected.to validate_confirmation_of(:password) }

    # format validations
    it { is_expected.to allow_value("my-Username_2015.").for(:login) }
    it { is_expected.to allow_value("A_bc1-2.3").for(:login) }
    it { is_expected.to_not allow_value("Bo").for(:login) }
    it { is_expected.to_not allow_value("this-is-absurdly-long-you-cannot-remember-it").for(:login) }
    it { is_expected.to_not allow_value("$p3@!< |ee+?").for(:login) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:trim_username).before(:create) }
  end
end

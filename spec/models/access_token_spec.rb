require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe "#validations" do
    it 'should have valid factory' do
    
    end

    it 'should have validate token' do 

    end
  end

  describe "#new" do
    it 'should have a token present after initialize' do
      expect(AccessToken.new.token).to be_present
    end

    it 'should generate uniq token' do
      user = create :user
      access_token = user.create_access_token
      expect(access_token.token).to eq(access_token.reload.token)
    end
  end
end

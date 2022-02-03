require 'rails_helper'

RSpec.describe Article, type: :model do
  it "tests a number to be a positive" do 
    expect(1).to be_positive #be_positive => 1.posiive? == true
  end
end

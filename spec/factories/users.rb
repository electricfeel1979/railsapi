# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "kevinmm#{n}" }
    name { 'Kevin MM' }
    url { 'http://example.com' }
    avatar_url { 'http://example.com/avatar' }
    provider { 'github' }
  end
end

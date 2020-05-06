# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'hoge@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end

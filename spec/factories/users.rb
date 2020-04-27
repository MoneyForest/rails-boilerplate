# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'hoge@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
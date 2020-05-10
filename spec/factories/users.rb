# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'hoge@example.com' }
    password { 'foobar' }
    created_at { Time.now }
    updated_at { Time.now }
    display_name { 'hogehoge' }
    profile { 'fuga' }
    name { 'John Smith' }
    birthday { '1990-01-01 00:00:00' }
    gender { 'male' }
    zip_code { '1234567' }
  end
end

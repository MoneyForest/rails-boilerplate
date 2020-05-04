# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable,
         omniauth_providers: %i[twitter facebook google]

  validates :display_name,
            length: { in: 1..15 },
            format: {
              with: /\A[a-z0-9]+\z/,
              message: 'は小文字英数字で入力してください'
            }

  validates :profile,
            length: { maximum: 160 }

  validates :name, length: { in: 1..15 }

  validate :birthday_is_past

  validates :gender, inclusion: { in: %w[male female] }, allow_blank: true

  validates :zip_code, length: { is: 7 }, numericality: { only_integer: true }

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user ||= User.create(
        uid: auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  private

  def birthday_is_past
    errors.add(:birthday, 'は今日以前の日付を選択してください') unless birthday < Date.today
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end

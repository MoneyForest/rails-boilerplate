# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable,
         omniauth_providers: %i[twitter facebook google]

  mount_uploader :icon_image, IconImageUploader
  mount_uploader :background_image, BackgroundImageUploader

  validates :display_name,
            length: { in: 1..15 },
            format: {
              with: /\A[a-z0-9]+\z/,
              message: 'は小文字英数字で入力してください'
            },
            on: :update

  validates :profile,
            length: { maximum: 160 },
            allow_blank: true,
            on: :update

  validates :name,
            length: { in: 1..15 },
            allow_blank: true,
            on: :update

  validate :birthday_is_past?,
           on: :update

  validates :gender,
            inclusion: { in: %w[male female] },
            allow_blank: true,
            on: :update

  validates :zip_code,
            length: { is: 7 },
            numericality: { only_integer: true },
            allow_blank: true,
            on: :update

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

  def birthday_is_past?
    return unless birthday

    if birthday > Date.today
      errors.add(:birthday, 'should be selected a day before today')
    end
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end

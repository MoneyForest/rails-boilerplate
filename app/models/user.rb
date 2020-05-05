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
            allow_blank: true,
            length: { maximum: 15 },
            format: {
              with: /\A[a-z0-9]+\z/,
              message: 'は小文字英数字で入力してください'
            },
            on: :update

  validates :profile,
            allow_blank: true,
            length: { maximum: 160 },
            on: :update

  validates :name,
            allow_blank: true,
            length: { in: 1..15 },
            on: :update

  validate :birthday_is_past?,
           on: :update

  validates :gender,
            allow_blank: true,
            inclusion: { in: %w[male female] },
            on: :update

  validates :zip_code,
            allow_blank: true,
            length: { is: 7 },
            numericality: { only_integer: true },
            on: :update

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user ||= User.new do |u|
        u.uid = auth.uid
        u.provider = auth.provider
        u.email = User.dummy_email(auth)
        u.password = Devise.friendly_token[0, 20]
      end
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

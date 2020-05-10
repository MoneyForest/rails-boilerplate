# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'display_name' do
    it 'is invalid more than 15 characters' do
      user = create(:user)
      expect(user).to be_valid

      user.display_name = 'morethan15characters'
      expect(user).to be_invalid
    end
  end

  context 'birthday' do
    it 'is invalid set a past date' do
      user = create(:user)
      expect(user).to be_valid

      user.birthday = Time.now + (60 * 60 * 24)
      expect(user).to be_invalid
    end
  end
end

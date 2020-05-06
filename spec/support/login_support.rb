# frozen_string_literal: true

module LoginSupport
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in create(:user)
    end
  end
end

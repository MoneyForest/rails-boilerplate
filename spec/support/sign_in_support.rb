# frozen_string_literal: true

module SignInSupport
  def sign_in_user
    user = set_user
    user.skip_confirmation!
    user.save!

    visit new_user_session_path
    fill_in 'Email',                 with: 'hoge@example.com'
    fill_in 'Password',              with: 'foobar'
    click_button 'Log in'

    sign_in user

    expect(page).to have_text('Signed in successfully.')
    expect(URI.parse(current_url).path.to_s).to eq(top_path)
  end

  def sign_out_user
    page.driver.submit :delete, destroy_user_session_path, {}

    expect(page).to have_text('Signed out successfully.')
    expect(URI.parse(current_url).path.to_s).to eq(root_path)
  end

  def set_user
    User.new do |u|
      u.email = 'hoge@example.com'
      u.password = 'foobar'
      u.password_confirmation = 'foobar'
    end
  end
end

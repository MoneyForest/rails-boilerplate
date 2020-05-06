# frozen_string_literal: true

module SignInSupport
  def sign_in_user
    user = create(:user)
    user.skip_confirmation!
    user.save!

    visit new_user_session_path
    fill_in 'Email',                 with: 'hoge@example.com'
    fill_in 'Password',              with: 'foobar'
    click_button 'Log in'

    sign_in user

    expect(URI.parse(current_url).path.to_s).to eq(top_path)
    expect(page).to have_text('Signed in successfully.')
  end
end

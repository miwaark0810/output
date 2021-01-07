module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード（6文字以上）', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end
end

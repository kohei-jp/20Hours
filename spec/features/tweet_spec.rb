require 'rails_helper'

feature 'tweet', type: :feature do
  let(:user) { create(:user) }

  scenario 'post tweet' do
    # ログイン前には投稿ボタンがない
    visit root_path
    expect(page).to have_no_content('投稿する')

    # ログイン処理
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    visit tweets_path
    expect(page).to have_content('投稿する')

     # ツイートの投稿
     expect {
      click_link('投稿する')
      expect(current_path).to eq new_tweet_path
      # find('input[type="file"]').click
      # attach_file "images[]", "/public/coffee.jpg"
      fill_in 'text', with: 'フィーチャスペックのテスト'
      fill_in 'tweet_time', with: 'フィーチャスペックのテスト'
      fill_in 'tweet_tag_attributes_tag_name', with: 'test'

      find('input[type="submit"]').click
    }.to change(Tweet, :count).by(1)
  end
end
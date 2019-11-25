require 'rails_helper'

RSpec.describe User, type: :system do
  before do
    # user_g = FactoryBot.create(:user, name: 'guest', email: 'g_user@gmail.com', password: 'useruser_g')
    # @user = FactoryBot.create(:user)
    # @user_a = FactoryBot.create(:admin_user)
  end

  describe 'ユーザー一覧画面' do
    context 'ユーザーを新規登録した場合' do
      before do
        visit new_user_path
        fill_in 'user_name', with: 'Factryによるデフォルトユーザー'
        fill_in 'user_email', with: 'd_user@gmail.com'
        fill_in 'user_password', with: 'useruser'
        fill_in 'user_password_confirmation', with: 'useruser'
        click_on 'ユーザー登録する'
      end

      it '同時にログインする' do
        expect(page).to have_content 'Factryによるデフォルトユーザーさんのページ'
      end
    end
  end

  describe 'ログイン中' do
    context 'ログインしてないのにタスクページに飛ぼうとした場合' do
      it 'ログインページに遷移する' do
        user = FactoryBot.create(:user)
        factory = FactoryBot.create(:task, user: user)
        visit task_path(factory)
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'ログイン中' do
    context 'ログイン中にユーザー登録画面に飛ぼうとした場合' do
      before do
        user = FactoryBot.create(:user)
        factory = FactoryBot.create(:task, user: user)
        visit new_session_path
        fill_in 'session_email', with: 'd_user@gmail.com'
        fill_in 'session_password', with: 'useruser'
        click_on 'ログイン'
      end
      it 'タスク一覧ページに遷移する' do
        visit new_user_path
        expect(page).to have_content "ユーザーのタスク一覧"
      end
    end
  end

  describe 'ログイン中' do
    context 'ログイン中に他のユーザー画面に飛ぼうとした場合' do
      before do
        user = FactoryBot.create(:user)
        factory = FactoryBot.create(:task, user: user)
        visit new_session_path
        fill_in 'session_email', with: 'd_user@gmail.com'
        fill_in 'session_password', with: 'useruser'
        click_on 'ログイン'
      end
      it '自分だけのタスク一覧ページに遷移する' do
        user_b = FactoryBot.create(:user, name: 'ユーザーB', email: 'b_user@gmail.com')
        factory_b = FactoryBot.create(:task, user: user_b)
        visit user_path(user_b)
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
  end

  describe '管理者' do
    context '管理者が新規ユーザー登録した場合' do
      before do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session_email', with: 'admin_user@gmail.com'
        fill_in 'session_password', with: 'useruseruser'
        click_on 'ログイン'
      end
      it '新規ユーザーが表示される' do
        visit admin_users_path
        visit new_admin_user_path
        fill_in 'user_name', with: 'Factryによるデフォルトユーザー'
        fill_in 'user_email', with: 'd_user@gmail.com'
        check 'user_admin'
        fill_in 'user_password', with: 'useruser'
        fill_in 'user_password_confirmation', with: 'useruser'
        click_button 'create'
        expect(page).to have_content 'ユーザー一覧'
      end
    end
  end

  describe '管理者' do
    context '管理者がユーザー詳細画面に遷移した場合' do
      before do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session_email', with: 'admin_user@gmail.com'
        fill_in 'session_password', with: 'useruseruser'
        click_on 'ログイン'
      end
      it 'ユーザー詳細が表示される' do
        user = FactoryBot.create(:user)
        visit admin_users_path
        visit admin_user_path(user)
        expect(page).to have_content 'd_user@gmail.com'
      end
    end
  end

  describe '管理者' do
    context '管理者がユーザー情報を更新した場合' do
      before do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session_email', with: 'admin_user@gmail.com'
        fill_in 'session_password', with: 'useruseruser'
        click_on 'ログイン'
      end
      it 'ユーザー更新情報が表示される' do
        user = FactoryBot.create(:user)
        visit admin_users_path
        visit edit_admin_user_path(user)
        fill_in 'user_name', with: 'Factryによるデフォルトユーザー'
        fill_in 'user_email', with: 'd_user@gmail.com'
        check 'user_admin'
        fill_in 'user_password', with: 'useruser'
        fill_in 'user_password_confirmation', with: 'useruser'
        # find_link('.update')
        # save_and_open_page
        # click_on('Update')
        # click_on 'update'
        # find('.update').click
        # click_link_or_button('commit')

        # click_button '更新'
        # click_on '更新'
        # find_button('更新')
        click_button('update')
        expect(page).to have_content 'ユーザー詳細'
      end
    end
  end

  describe '管理者' do
    context '管理者がユーザー情報を削除した場合' do
      before do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session_email', with: 'admin_user@gmail.com'
        fill_in 'session_password', with: 'useruseruser'
        click_on 'ログイン'
      end
      it 'ユーザー一覧が更新される' do
        user = FactoryBot.create(:user)
        visit admin_users_path
        all('tbody tr')[2].click_link '削除'
        #ダイアログの確認画面でOKをクリックさせる
        page.driver.browser.switch_to.alert.accept
        expect(all('tbody tr')).to_not have_content 'Factryによるデフォルトユーザー'
      end
    end
  end

end

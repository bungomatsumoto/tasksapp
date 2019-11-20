require 'rails_helper'
require 'date'


RSpec.describe "タスク管理機能", type: :system do
  before do
    user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a_user@gmail.com')
    # @admin_user = FactoryBot.create(:admin_user)
    @factory = FactoryBot.create(:task, title:'task', user: user_a)
    @factory2 = FactoryBot.create(:second_task, user: user_a)

    FactoryBot.create(:task, title: 'MMM', explanation: '09090909', deadline: '2024.3.2', user: user_a)
    FactoryBot.create(:task, title: 'GGG', explanation: '35353535353', deadline: '2028.3.2', user: user_a)
    FactoryBot.create(:task, title: 'QQQ', explanation: '35353535353', deadline: '2026.3.2', user: user_a)
    FactoryBot.create(:task, title: '55555', explanation: '%%%%%%', deadline: '2020.3.2', user: user_a)

    FactoryBot.create(:task, title: 'MMM', explanation: '09090909', priority: 2, user: user_a)
    FactoryBot.create(:task, title: 'GGG', explanation: '35353535353', priority: 0, user: user_a)
    FactoryBot.create(:task, title: 'QQQ', explanation: '35353535353', priority: 1, user: user_a)
    FactoryBot.create(:task, title: '55555', explanation: '%%%%%%', priority: 2, user: user_a)
  end

  describe 'タスク一覧画面' do
    context 'ユーザーAがログイン中にタスクを作成した場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'a_user@gmail.com'
        fill_in 'session_password', with: 'useruser'
        click_on 'ログイン'
      end

      it 'ユーザーAの作成済みタスクが表示される' do
        # visit tasks_path
        click_on 'ユーザーのタスク一覧'
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'タスク登録画面' do
    context 'ユーザーAが必要項目を入力して、createボタンを押した場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'a_user@gmail.com'
        fill_in 'session_password', with: 'useruser'
        click_on 'ログイン'
      end

      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'テストを書く'
        fill_in 'task_explanation', with: 'system specで書く'
        fill_in 'task_deadline', with: Date.today
        click_on '登録する'
        # ↑コントローラーのクリエイトアクションのredirect〜によって詳細へ遷移するはず
        expect(page).to have_content 'テストを書く', Date.today
      end
    end
  end

  describe 'タスク詳細画面' do
     context 'ユーザーAが任意のタスク詳細画面に遷移した場合' do
       before do
         visit new_session_path
         fill_in 'session_email', with: 'a_user@gmail.com'
         fill_in 'session_password', with: 'useruser'
         click_on 'ログイン'
       end

       it '該当タスクの内容が表示されたページに遷移すること' do
         visit tasks_path
         # click_on '詳細'
         visit task_path(@factory)
         expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１','Factoryで作ったデフォルトのコンテント１'

       end
     end
  end

  describe 'タスク一覧画面' do
     context 'ユーザーAがタスク一覧画面に遷移した場合' do
       before do
         visit new_session_path
         fill_in 'session_email', with: 'a_user@gmail.com'
         fill_in 'session_password', with: 'useruser'
         click_on 'ログイン'
       end

       it "タスクが作成日時の降順に並んでいる" do
         visit tasks_path
         # newest_task = Task.all.last
         # expect(first('tbody td')).to have_content 'Factoryで作ったデフォルトのタイトル２'
         expect(all('tbody tr')[1]).to have_content '55555'
       end
     end
  end

  describe 'タスク一覧画面' do
    context 'ユーザーAが終了期限並び替えリンクをクリックした場合' do
      before do

        visit new_session_path
        fill_in 'session_email', with: 'a_user@gmail.com'
        fill_in 'session_password', with: 'useruser'
        click_on 'ログイン'
      end

      it 'タスクが終了期限の降順で並ぶこと' do
        # click_on 'ユーザーのタスク一覧'
        visit tasks_path
        click_on '終了期限で並び替え'
        # FactoryBot.create(:task, title: 'MMM', explanation: '09090909', deadline: '2024.3.2')
        # FactoryBot.create(:task, title: 'GGG', explanation: '35353535353', deadline: '2028.3.2', user: @admin_user)
        # FactoryBot.create(:task, title: 'QQQ', explanation: '35353535353', deadline: '2026.3.2')
        # FactoryBot.create(:task, title: '55555', explanation: '%%%%%%', deadline: '2020.3.2')
        # expect(first('tbody td')).to have_content 'GGG'
        # expect(first('tbody td')).to have_content 'テストを書く','system specで書く'
        expect(all('tbody tr')[1]).to have_content '2028-03-02 '

      end
    end
  end

  describe 'タスク編集画面' do
    context 'ユーザーAが進捗プルダウンから変更した場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'a_user@gmail.com'
        fill_in 'session_password', with: 'useruser'
        click_on 'ログイン'
      end

      it '進捗が更新されること' do
        visit tasks_path
        visit edit_task_path(@factory2)
        select "着手中", from: "task_status"
        click_on '更新する'
        expect(page).to have_content '着手中'
      end
    end
  end

  describe 'タスク一覧画面' do
    context 'ユーザーAが優先順位並び替えリンクをクリックした場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'a_user@gmail.com'
        fill_in 'session_password', with: 'useruser'
        click_on 'ログイン'
      end

      it 'タスクが優先順位の降順で並ぶこと' do
        # visit tasks_path
        visit tasks_path
        click_on '優先順位で並び替え'
        expect(all('tbody tr').last).to have_content 'GGG'
        # expect(first('tbody td')).to have_content 'テストを書く','system specで書く'
      end
    end
  end


end

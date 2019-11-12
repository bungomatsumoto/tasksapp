require 'rails_helper'
require 'date'


RSpec.describe "タスク管理機能", type: :system do
  before do
    @factory = FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        task = FactoryBot.create(:task, title:'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'テストを書く'
        fill_in 'task_explanation', with: 'system specで書く'
        fill_in 'task_deadline', with: Date.today
        click_on '登録する'
        # dt = Date.today
        # ↑コントローラーのクリエイトアクションのredirect〜によって詳細へ遷移するはず
        expect(page).to have_content 'テストを書く', Date.today
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         visit tasks_path
         # click_on '詳細'
         visit task_path(@factory)
         expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１','Factoryで作ったデフォルトのコンテント１'

         # all('.option_order01').click_link('2')
         # save_and_open_page
         # show_link = find(:xpath, "//a[contains(@href,'tasks/show/2')]")
         # show_link.click
       end
     end
  end

  describe 'タスク一覧画面' do
     context 'タスク一覧画面に遷移した場合' do
       it "タスクが作成日時の降順に並んでいる" do
         visit tasks_path
         # newest_task = Task.all.last
         expect(first('tbody td')).to have_content 'Factoryで作ったデフォルトのタイトル２'
       end
     end
  end

  describe 'タスク一覧画面' do
    context '終了期限並び替えリンクをクリックした場合' do
      it 'タスクが終了期限の降順で並ぶこと' do
        Task.create(id: 1, title: 'MMM', explanation: '09090909', deadline: '2024.3.2')
        Task.create(id: 2, title: 'GGG', explanation: '35353535353', deadline: '2028.3.2')
        Task.create(id: 3, title: 'QQQ', explanation: '35353535353', deadline: '2026.3.2')
        Task.create(id: 4, title: '55555', explanation: '%%%%%%', deadline: '2020.3.2')
        visit tasks_path
        click_on '終了期限で並び替え'
        expect(first('tbody td')).to have_content 'GGG'
        # expect(first('tbody td')).to have_content 'テストを書く','system specで書く'
      end
    end
  end

  describe 'タスク一覧画面' do
    context '優先順位並び替えリンクをクリックした場合' do
      it 'タスクが優先順位の降順で並ぶこと' do
        Task.create(id: 1, title: 'MMM', explanation: '09090909', priority: 2)
        Task.create(id: 2, title: 'GGG', explanation: '35353535353', priority: 0)
        Task.create(id: 3, title: 'QQQ', explanation: '35353535353', priority: 1)
        Task.create(id: 4, title: '55555', explanation: '%%%%%%', priority: 2)
        visit tasks_path
        click_on '優先順位で並び替え'
        expect(all('tbody tr').last).to have_content 'GGG'
        # expect(first('tbody td')).to have_content 'テストを書く','system specで書く'
      end
    end
  end

end

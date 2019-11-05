require 'rails_helper'

RSpec.describe Task, type: :system do
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
        click_on 'Create Task'
        # ↑コントローラーのクリエイトアクションのredirect〜によって詳細へ遷移するはず
        expect(page).to have_content 'テストを書く','system specで書く'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         visit tasks_path
         click_on '詳細'
         expect(page).to have_content 'タスクの詳細'
       end
     end
  end

end


# ●タスク登録画面のデータ保存テスト　「5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く」　←このコードをコメントアウトしてもテストは成功。テストコードの正しさはどう検証するべき？
# ●タスク詳細画面の遷移テスト　詳細ページへ遷移させるためにタスクのidはどう取ればいい？

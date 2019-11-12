FactoryBot.define do

  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    explanation { 'Factoryで作ったデフォルトのコンテント１' }
    deadline { Date.today }
    status { 2 }
    priority { 2 }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    explanation { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { Date.today - 2 }
    status { 0 }
    priority { 0 }
  end
end

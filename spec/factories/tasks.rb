FactoryBot.define do

  # factory :label do
  #   name { 'aaa' }
  # end

  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    explanation { 'Factoryで作ったデフォルトのコンテント１' }
    deadline { Date.today }
    status { 2 }
    priority { 2 }

    # after(:create) do |task|
    #   create(:labelling, task: task, label: create(:label))
    # end
    after(:create) do |task|
      create_list(:label, 1, tasks: [task])
      # 数字は作成回数？
    end

    user
  end


  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    explanation { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { Date.today - 2 }
    status { 0 }
    priority { 0 }

    after(:create) do |task|
      create_list(:second_label, 1, tasks: [task])
      # 数字は作成回数？
    end

    user
  end
end

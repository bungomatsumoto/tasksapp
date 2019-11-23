require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', explanation: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "explanationが空ならバリデーションが通らない" do
    task = Task.new(title: '失敗！', explanation: '')
    expect(task).not_to be_valid
  end

  it "titleとexplanationに内容が記載されていればバリデーションが通る" do
    task = Task.new(title: '成功', explanation: '間違いなし')
    expect(task).to be_valid
  end

  it "search_title使用時、該当titleが一つの場合に一つ表示" do
    @task1 = Task.create(id: 1, title: 'MMM', explanation: '失敗テスト')
    @task2 = Task.create(id: 2, title: 'GGG', explanation: '失敗テスト')
    @task3 = Task.create(id: 3, title: 'QQQ', explanation: '失敗テスト')
    @task4 = Task.create(id: 4, title: '55555', explanation: '失敗テスト')
    expect(Task.search_title("GGG")).to include(@task2)
  end

  it "search_title使用時、該当titleが2つある場合に2つ表示" do
    @task1 = Task.create(id: 1, title: 'GGG', explanation: '失敗テスト')
    @task2 = Task.create(id: 2, title: 'GGG', explanation: '失敗テスト')
    @task3 = Task.create(id: 3, title: 'QQQ', explanation: '失敗テスト')
    @task4 = Task.create(id: 4, title: '55555', explanation: '失敗テスト')
    expect(Task.search_title("GGG")).to include(@task1, @task2)
  end

  it "search_status使用時、該当statusが一つの場合に一つ表示" do
    @task1 = Task.create(id: 1, title: 'MMM', explanation: '失敗テスト', status: 'wait')
    @task2 = Task.create(id: 2, title: 'GGG', explanation: '失敗テスト', status: 'wait')
    @task3 = Task.create(id: 3, title: 'QQQ', explanation: '失敗テスト', status: 'running')
    @task4 = Task.create(id: 4, title: '55555', explanation: '失敗テスト', status: 'wait')
    expect(Task.search_status(1)).to include(@task3)
  end

  it "search_status使用時、該当statusが2つある場合に2つ表示" do
    @task1 = Task.create(id: 1, title: 'GGG', explanation: '成功テスト', status: 'completed')
    @task2 = Task.create(id: 2, title: 'GGG', explanation: '失敗テスト', status: 'wait')
    @task3 = Task.create(id: 3, title: 'QQQ', explanation: '失敗テスト', status: 'running')
    @task4 = Task.create(id: 4, title: '55555', explanation: '失敗テスト', status: 'completed')
    expect(Task.search_status(2)).to include(@task1, @task4)
  end

  

end

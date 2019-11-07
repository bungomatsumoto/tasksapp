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
end

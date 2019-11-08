class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :explanation, presence: true, length: { maximum: 200 }
  validates :deadline, presence: true
  enum status: { wait: 0, running: 1, completed: 2 }
end

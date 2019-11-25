class Task < ApplicationRecord
  belongs_to :user, optional: true
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  enum status: { wait: 0, running: 1, completed: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }

  scope :search_title, -> (title) {
    next if title.blank?
    where("title LIKE ?", "%#{title}%")}
  scope :search_status, -> (status) {
    next if status.blank?
    where(status: "#{status}")}
  scope :search_label, -> (label) {
    next if label.blank?
    joins(:labellings).where("labellings.label_id": label)}

  # scope :search_title_status, -> (title, status) { where("title LIKE ?", "%#{title}%").where(status: "#{status}")}

  validates :title, presence: true, length: { maximum: 50 }
  validates :explanation, presence: true, length: { maximum: 200 }
  validates :deadline, presence: true
  paginates_per 10
end

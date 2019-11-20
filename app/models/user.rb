class User < ApplicationRecord
  before_destroy :cant_be_absent_admin_destroy

  before_update :cant_be_absent_admin_update

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 40 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy

  private

  # destroyを止めようとするのはadminがtrueの状態
  def cant_be_absent_admin_destroy
    throw(:abort) if User.where(admin: 'true').count <= 1 && admin?
  end

  # updateを止めようとするのはadminがfalseの状態
  def cant_be_absent_admin_update
    throw(:abort) if User.where(admin: 'true').count == 1 && !admin?
  end
end

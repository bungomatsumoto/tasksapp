FactoryBot.define do
  factory :user, class: User do
    name { 'Factryによるデフォルトユーザー' }
    email { 'd_user@gmail.com' }
    password { 'useruser' }
    # password　{ 'useruser' }
    # password_confirmation　{ 'useruser' }
    admin { false }
  end

  factory :admin_user, class: User do
    name { 'Factryによる管理ユーザー' }
    email { 'admin_user@gmail.com' }
    password { 'useruseruser' }
    # password { 'useruseruser' }
    # password_confirmation { 'useruseruser' }
    admin { true }
  end
end


- テーブルとカラム、データ型

  - table 'tasks'
    - title string
    - explanation text
    - status string
    - deadline timestamp
    - priority string
    - id references :user

  - table 'users'
    - name text
    - email text
    - password_digest text

  - table 'labels'
    - work boolean
    - lesson boolean
    - leisure boolean


- herokuへのデプロイ手順

  - masterブランチで作業
  - $ rails assets:precompile RAILS_ENV=production
  - $ git add #
  - $ git commit -m “#”
  - $ (heroku create)
  - $ git push heroku (development:)master
  - $ heroku run rails db:migrate
  - $ heroku run rails db:seed

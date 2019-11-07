
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

  - 1. masterブランチで作業
  - 2. $ rails assets:precompile RAILS_ENV=production
  - 3. $ git add #
  - 4. $ git commit -m “#”
  - 5. $ heroku create
  - 6. $ git push heroku master
  - 7. $ heroku run rails db:migrate

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

  

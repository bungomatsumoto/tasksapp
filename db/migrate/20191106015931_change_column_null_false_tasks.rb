class ChangeColumnNullFalseTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :title, null: false
    change_column_null :tasks, :explanation, null: false
  end
end

class ChangeColumnNullToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :title, null: true
    change_column_null :tasks, :explanation, null: true
  end
end

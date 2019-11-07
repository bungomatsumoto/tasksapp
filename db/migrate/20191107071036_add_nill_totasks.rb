class AddNillTotasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :deadline, :date, default: Date.today
    change_column_null :tasks, :deadline, false, Date.today
  end

  def down
    change_column :tasks, :deadline, :date, default: nil
    change_column_null :tasks, :deadline, true, nil
  end
end

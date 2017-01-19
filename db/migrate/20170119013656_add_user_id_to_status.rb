class AddUserIdToStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :statuses, :user_id, :integer
  end
end

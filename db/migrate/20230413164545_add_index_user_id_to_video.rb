class AddIndexUserIdToVideo < ActiveRecord::Migration[7.0]
  def change
    add_index :videos, :user_id
  end
end

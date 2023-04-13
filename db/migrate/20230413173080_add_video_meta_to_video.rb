class AddVideoMetaToVideo < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :likes_count, :integer, default: 0
    add_column :videos, :dislikes_count, :integer, default: 0
  end
end

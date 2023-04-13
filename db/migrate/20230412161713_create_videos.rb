class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.integer :video_source_id, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end

    add_index :videos, :video_source_id
  end
end

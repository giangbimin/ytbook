class CreateVideoSources < ActiveRecord::Migration[7.0]
  def change
    create_table :video_sources do |t|
      t.integer :provider, null: false, default: 1
      t.string :identify_id, null: false

      t.timestamps
    end
    add_index :video_sources, :identify_id
  end
end

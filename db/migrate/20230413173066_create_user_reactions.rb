class CreateUserReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reactions do |t|
      t.integer :user_id, null: false
      t.integer :video_id, null: false
      t.integer :reaction, null: false, defaut: 0

      t.timestamps
    end

    add_index :user_reactions, :user_id
    add_index :user_reactions, :video_id
  end
end

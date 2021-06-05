class CreateEmoteReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :emote_reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :emotionable, polymorphic: true, null: false
      t.integer :kind, null: false

      t.timestamps
    end

    add_index :emote_reactions, [
      :user_id, :emotionable_id, :emotionable_type, :kind
    ], unique: true, name: :index_emote_reactions_on_user_id_and_emotionable_and_kind
  end
end

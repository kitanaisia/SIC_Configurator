class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.integer :deck_id
      t.integer :memberlist_id
      t.integer :setlist_id

      t.timestamps
    end
  end
end

class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.integer :card_id
      t.integer :rarerity
      t.string :birthday
      t.string :grade
      t.string :piece1
      t.string :piece2
      t.string :piece3
      t.string :piece4
      t.string :bonus
      t.string :ability
      t.string :costume

      t.timestamps
    end
  end
end

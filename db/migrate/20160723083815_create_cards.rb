class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :card_id
      t.string :name
      t.string :number
      t.string :skill

      t.timestamps
    end
  end
end

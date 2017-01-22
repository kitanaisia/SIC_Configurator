class CreateSetlists < ActiveRecord::Migration[5.0]
  def change
    create_table :setlists do |t|
      t.integer :memberlist_id
      t.string :number
      t.integer :count

      t.timestamps
    end
  end
end

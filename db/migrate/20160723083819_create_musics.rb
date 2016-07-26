class CreateMusics < ActiveRecord::Migration[5.0]
  def change
    create_table :musics do |t|
      t.integer :card_id
      t.string :color
      t.integer :live_p_base
      t.string :live_p_extra
      t.string :integer
      t.integer :score_red
      t.integer :score_green
      t.integer :score_blue
      t.integer :score_common

      t.timestamps
    end
  end
end

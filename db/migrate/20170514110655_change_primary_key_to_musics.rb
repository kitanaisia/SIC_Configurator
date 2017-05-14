class ChangePrimaryKeyToMusics < ActiveRecord::Migration[5.0]
  def change
    remove_column :musics, :card_id, :integer
    add_column :musics, :number, :string
  end
end

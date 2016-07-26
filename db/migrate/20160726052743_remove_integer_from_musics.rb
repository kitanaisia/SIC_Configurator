class RemoveIntegerFromMusics < ActiveRecord::Migration[5.0]
  def change
    remove_column :musics, :integer, :string
  end
end

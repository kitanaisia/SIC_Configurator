class AddImgToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :img, :string
  end
end

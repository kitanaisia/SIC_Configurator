class AddRarityToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :rarity, :integer
  end
end

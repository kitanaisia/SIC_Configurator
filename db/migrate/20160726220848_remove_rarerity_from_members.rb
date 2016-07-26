class RemoveRarerityFromMembers < ActiveRecord::Migration[5.0]
  def change
    remove_column :members, :rarerity, :integer
  end
end

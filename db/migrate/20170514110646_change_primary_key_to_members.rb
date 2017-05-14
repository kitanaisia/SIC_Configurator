class ChangePrimaryKeyToMembers < ActiveRecord::Migration[5.0]
  def change
    remove_column :members, :card_id, :integer
    add_column :members, :number, :string
  end
end

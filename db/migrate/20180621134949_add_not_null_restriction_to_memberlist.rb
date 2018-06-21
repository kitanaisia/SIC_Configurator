class AddNotNullRestrictionToMemberlist < ActiveRecord::Migration[5.0]
  def change
    change_column :memberlists, :start, :boolean, null: false, default: false
  end
end

class AddStartToMemberlist < ActiveRecord::Migration[5.0]
  def change
    add_column :memberlists, :start, :boolean
  end
end

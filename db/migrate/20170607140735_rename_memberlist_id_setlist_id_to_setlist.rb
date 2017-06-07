class RenameMemberlistIdSetlistIdToSetlist < ActiveRecord::Migration[5.0]
  def change
    rename_column :setlists, :memberlist_id, :setlist_id
  end
end

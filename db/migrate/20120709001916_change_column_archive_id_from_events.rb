class ChangeColumnArchiveIdFromEvents < ActiveRecord::Migration
  def up
    rename_column :events, :archive_id, :ustream_archive_id
  end
  
  def down
  end
end

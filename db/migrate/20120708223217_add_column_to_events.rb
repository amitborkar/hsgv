class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :archive_id, :integer
  end
end

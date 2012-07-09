class AddColumnSourceToEvents < ActiveRecord::Migration
  def change
    add_column :events, :source, :integer
  end
end

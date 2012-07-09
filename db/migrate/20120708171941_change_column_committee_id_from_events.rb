class ChangeColumnCommitteeIdFromEvents < ActiveRecord::Migration
  def up
    change_column :events, :committee_id, :string
  end

  def down
  end
end

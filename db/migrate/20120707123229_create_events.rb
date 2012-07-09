class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.integer :committee_id
      t.datetime :start_date

      t.timestamps
    end
  end
end

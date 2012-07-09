class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end

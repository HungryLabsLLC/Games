class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :match_id
      t.integer :player
      t.string :value

      t.timestamps
    end
  end
end

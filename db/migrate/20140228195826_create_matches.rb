class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :game
      t.integer :players
      t.string :status
      t.string :outcome

      t.timestamps
    end
  end
end

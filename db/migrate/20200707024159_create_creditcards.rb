class CreateCreditcards < ActiveRecord::Migration[5.2]
  def change
    create_table :creditcards do |t|
      t.integer :card_number,        null: false
      t.integer :expiration_year,    null: false
      t.integer :expiration_month,   null: false
      t.integer :security_code,      null: false
      t.integer :user_id,            null: false, foreign_key: true
      t.timestamps
    end
    add_index :creditcards, :card_number, unique: true
  end
end

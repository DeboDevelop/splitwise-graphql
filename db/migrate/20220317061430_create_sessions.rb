class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :key
      t.datetime :expires_at

      t.timestamps
    end
  end
end

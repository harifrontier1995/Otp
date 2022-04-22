class CreateApiTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :api_tokens do |t|
      t.integer :user_id
      t.text :token
      t.time :ttl
      t.boolean :is_active

      t.timestamps
    end
  end
end

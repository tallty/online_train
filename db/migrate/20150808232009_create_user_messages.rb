class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.references :user, index: true
      t.references :message, index: true
      t.boolean :status, default: 0

      t.timestamps null: false
    end
  end
end

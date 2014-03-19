class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.references :user, index: true
      t.references :notification, index: true

      t.timestamps
    end
  end
end

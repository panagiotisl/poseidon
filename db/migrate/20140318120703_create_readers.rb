class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.references :user, index: true
      t.references :notification, index: true
      t.references :conversation, index: true
      
      t.timestamps

    end
  end
end

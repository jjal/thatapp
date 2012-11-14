class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :id
      t.string :email
      t.string :browser
      t.string :os

      t.timestamps
    end
  end
end

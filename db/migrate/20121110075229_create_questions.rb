class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :id
      t.string :content
      t.integer :sort

      t.timestamps
    end
  end
end

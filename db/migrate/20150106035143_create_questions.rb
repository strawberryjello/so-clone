class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :text
      t.integer :votes
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end

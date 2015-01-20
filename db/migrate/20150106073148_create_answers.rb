class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :votes
      t.references :question, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end

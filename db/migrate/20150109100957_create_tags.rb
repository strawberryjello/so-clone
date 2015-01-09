class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :tags_questions, id: false do |t|
      t.belongs_to :tags, index: true
      t.belongs_to :questions, index: true
    end
  end
end

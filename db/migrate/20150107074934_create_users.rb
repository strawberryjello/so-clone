class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :hashed_password
      t.string :email
      t.string :salt

      t.timestamps null: false
    end
  end
end

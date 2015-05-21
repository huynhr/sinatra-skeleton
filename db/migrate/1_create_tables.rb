class CreateTables < ActiveRecord::Migration

  def change
    create_table :user do |t|
      t.string :username
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :movies do |t|
      # Your code goes here
      t.string   :title
      t.string   :genre
      t.integer  :ratings
      t.date     :release_date
      t.integer  :length
      t.string   :directed_by
      t.timestamps
    end

    create_table :reviews do |t|
      t.date    :date
      t.integer :ratings
      t.string  :comments
    end

  end

end
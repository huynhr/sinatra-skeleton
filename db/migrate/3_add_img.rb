class AddImg < ActiveRecord::Migration
    def change
        change_table :movies do |t|
            t.string :img
        end

    end

end
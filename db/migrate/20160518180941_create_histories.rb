class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.belongs_to :audition, index: true
      t.string :action

      t.timestamps null: false
    end
  end
end

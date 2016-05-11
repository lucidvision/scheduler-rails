class CreateAuditions < ActiveRecord::Migration
  def change
    create_table :auditions do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.string :actor
      t.string :role
      t.string :phone
      t.string :date
      t.string :time
      t.string :status
      t.string :response

      t.timestamps null: false
    end
  end
end

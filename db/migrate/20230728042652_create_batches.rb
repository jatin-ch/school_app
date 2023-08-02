class CreateBatches < ActiveRecord::Migration[6.1]
  def change
    create_table :batches do |t|
      t.string :name, null: false
      t.integer :size, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :course_id, null: false
      t.integer :status

      t.timestamps
    end
  end
end

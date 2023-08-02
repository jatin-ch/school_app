class CreateEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrollments do |t|
      t.integer :status, null: false
      t.integer :user_id, null: false
      t.integer :batch_id, null: false

      t.timestamps
    end
  end
end

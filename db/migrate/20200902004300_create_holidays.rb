class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|
      t.references :term, null: false, foreign_key: true
      t.integer :employee_id
      t.integer :status
      t.date :day

      t.timestamps
    end
  end
end

class CreateTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :terms do |t|
      t.string :code
      t.date :start
      t.date :end
      t.timestamps
    end
  end
end

class CreatePatient < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :p_name
      t.string :p_address
      t.string :col_name
      t.string :col_date
      t.string :diag_code
      t.string :other_test_code
      t.string :phy_name
      t.string :phy_email
      t.string :clinic_address
      t.timestamps
    end
  end
end

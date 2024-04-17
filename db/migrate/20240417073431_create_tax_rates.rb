class CreateTaxRates < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_rates do |t|
      t.string :province
      t.float :pst
      t.float :gst
      t.float :hst

      t.timestamps
    end
  end
end

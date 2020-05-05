class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.text :patient_prescription

      t.timestamps
    end
  end
end

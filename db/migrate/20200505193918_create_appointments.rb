class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.text :doctor_prescription
      t.string :doctor_id
      t.string :patient_id

      t.timestamps null: false
    end
  end
end

class Doctor < ApplicationRecord
    has_secure_password

    has_many :appointments
    has_many :patients, {:through=>:appointments, :source=>"patient"}
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
end

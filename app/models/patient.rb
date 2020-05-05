class Patient < ApplicationRecord
    has_secure_password
    
    has_many :appointments
    has_many :doctors, through: :appointments
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
end

class Appointment < ApplicationRecord
    belongs_to :doctor
    belongs_to :patient
    has_many :patients
    accepts_nested_attributes_for :patients
    validates :date, presence: true
    validates :date, uniqueness: true
    validates :doctor_id, presence: true
    validates :patient_id, presence: true

    attr_accessor :entry_date_formatted
    attr_accessor :entry_date

    scope :search, ->(date) { where("date > ?", date) }

    def entry_date_formatted
        self.date.strftime '%d.%m.%Y %H:%M:%S' unless self.entry_date.nil?
    end
    
    def entry_date_formatted=(value)
        return if value.nil? or value.blank?
        self.date = DateTime.strptime(value, '%d.%m.%Y %H:%M:%S').to_date
    end

end

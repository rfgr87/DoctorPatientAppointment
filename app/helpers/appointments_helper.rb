module AppointmentsHelper
    def display_form_header
        if @patient
            "Create a new appointment for #{@patient.name}"
        else
            "Create a new appointment"
        end
    end

end

module ApplicationHelper
    
    def current_doctor
        @current_doctor ||= Doctor.find(session[:doctor_id]) if session[:doctor_id]
    end

    def current_patient
        @current_patient ||= Patient.find(session[:patient_id]) if session[:patient_id]
    end

    def logged_in_doctor?
        if session[:doctor_id]
            true
        else
            false
        end
    end

    def logged_in_patient?
        if session[:patient_id]
            true
        else
            false
        end
    end

end

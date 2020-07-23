class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include ApplicationHelper

    def home
        
    end

    private
    
    def doctor_params
        params.require(:doctor).permit(:name, :email, :password, :password_confirmation)
    end

    def doctor_id
        session[:doctor_id]
    end

    def patient_params
        params.require(:patient).permit(:name, :email, :password, :password_confirmation)
    end

    def patient_id
        session[:patient_id]
    end
end

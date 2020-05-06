class PatientsController < ApplicationController
    def new
        @patient = Patient.new
    end
    
    def create
        @patient = Patient.new(patient_params)
        if @patient.save
          session[:patient_id] = @patient.id
          redirect_to homepage_path(@patient)
        else
          redirect_to '/'
        end
    end
     
    def show
        @patient = Patient.find(params[:id])
    end
    
    def update
        @patient = Patient.find(params[:id])
        @patient.update(patient_params)
        redirect_to post_path(@patient)
    end
    
    def login
        @patient = Patient.find(email: params[:patient][:email])
        if @patient.id && @patient.authenticate(params[:patient][:password])
            session[:patient_id] = @patient.id
            redirect_to 'show'
        else
            redirect_to '/'
        end
    end
    
    def index
        if session[:patient_id]
          @appointments = Patient.find(session[:patient_id]).appointments
        else
          redirect_to '/'
        end
    end

    def edit
        @doctor = Doctor.find(params[:id])
    end

    def logout
        session.delete :patient_id
        redirect_to '/'
    end

    private
    
    def patient_params
        params.require(:patient).permit(:name, , :email, :password, :password_confirmation)
    end
end

class PatientsController < ApplicationController
    def new
        @patient = Patient.new
    end
    
    def create
        @patient = Patient.new(patient_params)
        if @patient.save
            session[:patient_id] = @doctor.id
            render :show
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
        redirect_to patient_path(@patient)
    end
    
    def login
    end

    def create_session 
        @patient = Patient.find_by(email: params[:email])
        if @patient.id && @patient.authenticate(params[:password])
            session[:patient_id] = @patient.id
            render :show
        else
            redirect_to '/'
        end
    end

    def facebook_create
        @patient = Patient.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
          #u.image = auth['info']['image']
        end
     
        if @patient
            session[:patient_id] = @patient.id
            render :show
        else
            redirect_to '/'
        end
    end
    
    
    def index
        @doctor = Doctor.find(doctor_id)
        @p = Patient.all.select do |patient|
            patient.appointments.empty?
        end
    end

    def edit
        @patient = Patient.find(patient_id)
    end

    def logout
        session.delete :patient_id
        redirect_to '/'
    end

    private
    def auth
        request.env['omniauth.auth']
    end
end

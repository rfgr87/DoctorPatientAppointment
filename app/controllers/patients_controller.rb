class PatientsController < ApplicationController
    def new
        @patient = Patient.new
    end
    
    def create
        @patient = Patient.new(patient_params)
        if @patient.save
            session[:patient_id] = @patient.id
            redirect_to patient_path(@patient.id)
        else
            render :new
        end
    end
    
    def failure
    end

    def show
        if !session[:patient_id].nil? || !session[:doctor_id].nil?
            @patient = Patient.find(params[:patient_id])
        else
            render patients_failure_path
        end
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
        if @patient && @patient.authenticate(params[:password])
            session[:patient_id] = @patient.id
            redirect_to patient_path(@patient.id)
        else
            render :failure
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
        @all_patients = Patient.all;
    end

    def edit
        if !session[:patient_id].nil?
            @patient = Patient.find(patient_id)
        else
            render patients_failure_path
        end
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

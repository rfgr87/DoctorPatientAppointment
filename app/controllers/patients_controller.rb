require 'pry'
class PatientsController < ApplicationController
    before_action :require_patient_or_doctor_login
    skip_before_action :require_patient_or_doctor_login, only: [:login, :create_session, :create, :new, :facebook_create]



    def new
        @patient = Patient.new
    end
    
    def create
        @patient = Patient.new(patient_params)
        if @patient.save
            session[:patient_id] = @patient.id
            redirect_to patient_path(@patient.id)
        else
            @message = "There was something wrong with the information given. 
            Please try again."
            render :new
        end
    end
    
    def failure
    end

    def show
        if session[:patient_id]
            @patient = Patient.find(session[:patient_id])
        elsif session[:doctor_id]
            @patient = Patient.find(params[:id])
        end

    end
    
    def update
        @patient = Patient.find(params[:id])
        @patient.update(patient_params)
        redirect_to patient_path(@patient)
    end
    
    def login
        @flag = false
    end

    def create_session 
        @patient = Patient.find_by(email: params[:email])
        if @patient && @patient.authenticate(params[:password])
            session[:patient_id] = @patient.id
            redirect_to patient_path(@patient.id)
        else
            @flag = true
            render :login
        end
    end

    def facebook_create
        @patient = Patient.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
          u.password= SecureRandom.hex(15)
          #u.image = auth['info']['image']
        end
     
        if @patient
            session[:patient_id] = @patient.id
            redirect_to patient_path(@patient.id)
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
        if current_patient
            @patient = current_patient
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

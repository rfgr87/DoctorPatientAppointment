require 'pry'

class DoctorsController < ApplicationController
    def new
        @doctor = Doctor.new
    end
    
    def create
        @doctor = Doctor.create(doctor_params)
        if @doctor.save
          session[:doctor_id] = @doctor.id
          render :show
        else
          redirect_to '/'
        end
    end

    def login
    end

    def create_session 
        @doctor = Doctor.find_by(email: params[:email])
        if @doctor.id && @doctor.authenticate(params[:password])
            session[:doctor_id] = @doctor.id
            render :show
        else
            redirect_to '/'
        end
    end
    
    def index
        if session[:doctor_id]
          @appointments = Doctor.find(session[:doctor_id]).appointments
        else
          redirect_to '/'
        end
    end
     
    def show
        @doctor = Doctor.find(doctor_id)
    end

    def patients
        @doctor = Doctor.find(doctor_id)
        @p = Patient.all.select do |patient|
            patient.appointments.empty?
            end
    end



    def update
        @doctor = Doctor.find(params[:id])
        @doctor.update(doctor_params)
        render :show
    end

    def edit
        @doctor = Doctor.find(doctor_id)
    end
    
    def logout
        session.delete :doctor_id
        redirect_to '/'
    end


end

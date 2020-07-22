require 'pry'

class DoctorsController < ApplicationController
    def new
        @doctor = Doctor.new
    end
    
    def create
        @doctor = Doctor.create(doctor_params)
        if @doctor.save
          session[:doctor_id] = @doctor.id
          redirect_to doctor_path(@doctor.id)
        else
            render :new
        end
    end

    def login
    end

    def create_session 
        @doctor = Doctor.find_by(email: params[:email])
        if @doctor && @doctor.authenticate(params[:password])
            session[:doctor_id] = @doctor.id
            redirect_to doctor_path(@doctor.id)
        else
            render :failure
        end
    end
    
    def failure
    end

    def index
        if session[:doctor_id]
          @appointments = Doctor.find(session[:doctor_id]).appointments
        else
          redirect_to '/'
        end
    end
     
    def show
        if session[:doctor_id].nil?
            render doctors_failure_path
        else
        @doctor = Doctor.find(doctor_id)
        end
    end

    # def patients
    #     @doctor = Doctor.find(doctor_id)   
    # end

    def delete
        @doctor = Doctor.find(doctor_id)
        @p = @doctor.patients
    end


    def update
        @doctor = Doctor.find(params[:id])
        @doctor.update(doctor_params)
        render :show
    end

    def edit
        if !session[:doctor_id].nil?
            @doctor = Patient.find(doctor_id)
        else
            render doctors_failure_path
        end
    end
    
    def logout
        session.delete :doctor_id
        redirect_to '/'
    end


end

require 'pry'

class DoctorsController < ApplicationController
    before_action :require_doctor_login
    skip_before_action :require_doctor_login, only: [:login, :create_session]

    
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
        @doctor = Doctor.find(session[:doctor_id])
        end
    end

    def delete
        @p = current_doctor.patients
    end


    def update
        @doctor = Doctor.find(params[:id])
        @doctor.update(doctor_params)
        # if it updates then redirect to the show page, 
        # if not re render the edit page
        render :show
    end

    def edit
        if !session[:doctor_id].nil?
            @doctor = current_doctor
        else
            render doctors_failure_path
        end
    end
    
    def logout
        session.delete :doctor_id
        redirect_to '/'
    end


end

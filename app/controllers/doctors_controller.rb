require 'pry'

class DoctorsController < ApplicationController
    before_action :require_doctor_login
    skip_before_action :require_doctor_login, only: [:login, :create_session, :new, :create]

    
    def new
        @doctor = Doctor.new
    end
    
    def create
        @doctor = Doctor.create(doctor_params)
        if @doctor.save
          session[:doctor_id] = @doctor.id
          redirect_to doctor_path(@doctor.id)
        else
            @message = "There was something wrong with the information given.
            Please try again."
            render :new
        end
    end

    def login
        @flag = false
    end

    def create_session 
        @doctor = Doctor.find_by(email: params[:email])
        if @doctor && @doctor.authenticate(params[:password])
            session[:doctor_id] = @doctor.id
            redirect_to doctor_path(@doctor.id)
        else
            @flag = true
            render :login
        end
    end
    
    def failure
    end

    def index
        @doctors = Doctor.all
    end
     
    def show      
        @doctor = current_doctor
    end

    def search
    end

    def search_results
        #@date = DateTime.new(params[:date])
        @doctors = Doctor.search(params[:name])
        #binding.pry
        render :search_results
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
        @doctor = current_doctor
    end
    
    def logout
        session.delete :doctor_id
        redirect_to '/'
    end


end

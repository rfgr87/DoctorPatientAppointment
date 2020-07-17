require 'pry'
class AppointmentsController < ApplicationController
    # before_action :method_to_be_called, only:

    def new
        @appointment = Appointment.new
        @doctor = Doctor.find(doctor_id)
        @patients = Patient.all
    end
        
    def create
        @doctor = Doctor.find(doctor_id)
        @appointment = @doctor.appointments.new(appointment_params)
        if @appointment.date
            @appointment.save
            render :show
        else
            render :new
        end
    end
    
    def search
    end

    def search_results
        #@date = DateTime.new(params[:date])
        @appointments = Appointment.search(params[:date])
        #binding.pry
        render :search_results
    end

    def index
        if session[:doctor_id]
            @appointments = Doctor.find(session[:doctor_id]).appointments
        elsif session[:patient_id]
            @appointments = Patient.find(session[:patient_id]).appointments
            redirect_to '/'
        end
    end
         
    def show
        if session[:doctor_id]
            @doctor = Doctor.find(doctor_id)
        elsif session[:patient_id]
            @patient = Patient.find(patient_id)
        end  
        @appointment = Appointment.find(params[:id])
    end

    def destroy
        if !Appointment.find_by_id(params[:id]).nil?  
            Appointment.find(params[:id]).destroy          
            redirect_to doctor_path(doctor_id)
        else
            redirect_to doctor_path(doctor_id)
        end
    end

    def update
        @appointment = Appointment.find(params[:appointment_id])
        @appointment.update(appointment_params)
        redirect_to appointment_path(@appointment)
    end
    
    def edit
        @appointment = Appointment.find(params[:appointment_id])
    end

    def prescription
        @appointment = Doctor.find(doctor_id).appointments.last
    end

    def create_prescription
        #binding.pry
        @appointment = Appointment.find(params[:id].to_i)
        # @patient = Appointment.find(id: params[:id]).patient 
        # @doctor = Appointment.find(id: params[:id]).doctor
        @appointment.doctor_prescription = params[:content]
        @appointment.save
        render :show
    end
        
    private

    #define method_to_be_called

    # def date_params
    #     params.require(:appointment).permit(params[:appointment]["date(1i)"].to_i,params[:appointment]["date(2i)"].to_i,
    #     params[:appointment]["date(3i)"].to_i, params[:appointment]["date(4i)"].to_i,
    #     params[:appointment]["date(5i)"].to_i)
    # end
        
    def appointment_params
        params.require(:appointment).permit(:date, :doctor_id, :patient_id)
    end

end

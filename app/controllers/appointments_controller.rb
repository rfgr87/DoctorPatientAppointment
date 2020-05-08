class AppointmentsController < ApplicationController

    def new
        @appointment = Appointment.new
        @doctor = Doctor.find(doctor_id)
        @patients = Patient.all.select do |patient|
        patient.appointments.nil?
        end
    end
        
    def create
        @doctor = Doctor.find_by(name: params[:doctor_id])
        @patient = Patient.find_by(name: params[:patient_name])
        @appointment = Appointment.create(appointment_params)
        @doctor.appointments << @appointment
        @patient.appointments << @appointment
        if @appointment.save && @doctor.save && @patient.save
            render :show
        else
            redirect_to '/'
        end
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
    end
    
    def update
        @appointment = Appointment.find(params[:appointment_id])
        @appointment.update(appointment_params)
        redirect_to appointment_path(@appointment)
    end
    
    def edit
        @appointment = Appointment.find(params[:appointment_id])
    end
        
    private
        
    def appointment_params
        params.require(:appointment).permit(:date, :doctor_id, :patient_id)
    end

end

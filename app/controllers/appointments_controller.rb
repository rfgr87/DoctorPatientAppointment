require 'pry'
class AppointmentsController < ApplicationController

    def new
        @appointment = Appointment.new
        @doctor = Doctor.find(doctor_id)
        @patients = Patient.all.select do |patient|
        patient.appointments.empty?
        end
    end
        
    def create
        @doctor = Doctor.find(doctor_id)
        #@patient = Patient.find(params[:appointment][:patient_id])
        date = DateTime.new(params[:appointment]["date(1i)"].to_i,params[:appointment]["date(2i)"].to_i,
        params[:appointment]["date(3i)"].to_i, params[:appointment]["date(4i)"].to_i,
        params[:appointment]["date(5i)"].to_i)
        @appointment = Appointment.create(doctor_id: @doctor.id, patient_id: params[:appointment][:patient_id], date: date)
        if @appointment.save
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
        @appointment = Appointment.find(params[:id])
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
        binding.pry
        @appointment = Appointment.find(params[:id].to_i)
        # @patient = Appointment.find(id: params[:id]).patient 
        # @doctor = Appointment.find(id: params[:id]).doctor
        @appointment.doctor_prescription = params[:content]
        @appointment.save
        render :show
    end
        
    private
        
    def appointment_params
        params.require(:appointment).permit(:date, :doctor_id, :patient_id)
    end

end

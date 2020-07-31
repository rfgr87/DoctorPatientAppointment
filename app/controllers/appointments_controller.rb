require 'pry'
class AppointmentsController < ApplicationController
    before_action :require_patient_or_doctor_login
    
    def new
        @appointment = Appointment.new
        if params[:patient_id]
            @patient = Patient.find(params[:patient_id])
        end  
    end
        
    def create
        @appointment = current_doctor.appointments.new(appointment_params)
        if @appointment.date > DateTime.now 
            if @appointment.save 
                redirect_to doctor_appointment_path(doctor_id, @appointment.id)
            end
        else
            if params[:patient_id]
                @patient = Patient.find(params[:patient_id])
            end
            @message = "Date has to be in the future."
            render :new
        end
    end
    
    def search
    end

    def search_results
        @appointments = Appointment.search(params[:date])
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
        if !doctor_id.nil?
            @doctor = Doctor.find(doctor_id)
            @appointment = Appointment.find(params[:id])
        elsif session[:patient_id]
            @patient = Patient.find(patient_id)
            @appointment = Appointment.find(params[:id])
        else
            render appointments_failure_path
        end  
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
        redirect_to appointment_path(@appointment.id)
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

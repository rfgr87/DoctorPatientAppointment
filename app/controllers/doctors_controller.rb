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
        @doctor = Doctor.new
        # redirect_to '/doctors/login'
        # @doctor = Doctor.find(email: params[:doctor][:email])
        # if @doctor.id && @doctor.authenticate(params[:doctor][:password])
        #     session[:doctor_id] = @doctor.id
        # else
        #     redirect_to '/'
        # end
    end
    
    def index
        if session[:doctor_id]
          @appointments = Doctor.find(session[:doctor_id]).appointments
        else
          redirect_to '/'
        end
    end
     
    # def show
    #     @doctor = Doctor.find_by(email: params[:doctor][:email])
    # end

    def update
        @doctor = Doctor.find(params[:id])
        @doctor.update(doctor_params)
        redirect_to post_path(@doctor)
    end

    def edit
        @doctor = Doctor.find(params[:id])
    end
    
    def logout
        session.delete :doctor_id
        redirect_to '/'
    end

    private
    
    def doctor_params
        params.require(:doctor).permit(:name, :email, :password, :password_confirmation)
    end

end

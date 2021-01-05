class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.save
    redirect_to patients_path
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def show
    @patient = Patient.find(params[:id])
    @msg = SimpleHL7::Message.new
    @msg.msh[9][1] = "hl7-demo"
    @msg.msh[9][2] = "20210104"
    @msg.msh[10][1] = "ORM"
    @msg.msh[11][2] = "O01"
    @msg.msh[14] = "2.5"
    @msg.pid[3] = @patient.id
    @msg.pid[5][1] = @patient.p_name.split(' ')[1]
    @msg.pid[5][2] = @patient.p_name.split(' ')[0]
    @msg.pv1[2] = @patient.diag_code
    @msg.pv1[3] = @patient.other_test_code
    @msg.pv1[10][1] = @patient.phy_name.split(' ')[1]
    @msg.pv1[10][2] = @patient.phy_name.split(' ')[0]
    @msg = @msg.to_hl7
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.update(patient_params)
    redirect_to patient_path(params[:id])
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    flash[:success] = 'Patient is deleted successfully'
    redirect_to patients_path
  end

  private

  def patient_params
    params.require(:patient).permit(:p_name, :p_address, :col_name, :col_date,
                                    :diag_code, :other_test_code, :phy_name,
                                    :phy_email, :clinic_address)
  end
end

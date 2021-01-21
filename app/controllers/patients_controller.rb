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
  end

  def update
    @patient = Patient.find(params[:id])
    byebug
    @patient.update(patient_params)
    redirect_to patient_path(params[:id])
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    flash[:success] = 'Patient is deleted successfully'
    redirect_to patients_path
  end


  def decrypt_hl7
    @patient1 = Patient.find(params[:id])
    @msg = @patient1.hl_7
    @msg = SimpleHL7::Message.parse(@msg)
    @patient = Patient.new
    @patient.col_name = @msg.msh[5]
    @patient.col_date = @msg.msh[7]
    @patient.p_last_name = @msg.pid[5][1]
    @patient.p_first_name = @msg.pid[5][2]
    @patient.diag_code = @msg.pv1[6]
    @patient.other_test_code = @msg.pv1[7]
    @patient.phy_last_name = @msg.pv2[10][1]
    @patient.phy_first_name = @msg.pv2[10][2]
    obx1 = @msg.segment('OBX', 1)
    @patient.weight = obx1[5].to_s
    obx2 = @msg.segment('OBX', 2)
    @patient.height = obx2[5].to_s
    obx3 = @msg.segment('OBX', 3)
    @patient.bmi = obx3[5].to_s
    obx4 = @msg.segment('OBX', 4)
    @patient.pulse = obx4[5].to_s
    obx5 = @msg.segment('OBX', 5)
    @patient.blood_pressure = obx5[5].to_s

  end

  private

  def patient_params
    params.require(:patient).permit(:p_first_name, :p_last_name, :p_address, :col_name, :col_date,
                                    :diag_code, :other_test_code, :phy_first_name, :phy_last_name,
                                    :phy_email, :clinic_address, :blood_pressure, :pulse, :height,
                                    :weight, :bmi)
  end
end

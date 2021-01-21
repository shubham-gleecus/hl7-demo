class PatientHl7sController < ApplicationController

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new
    # patient = params[:patient]
    # @msg = patient[:hl_7]
    # @msg = SimpleHL7::Message.parse(@msg)
    # @patient.col_name = @msg.msh[5]
    # @patient.col_date = @msg.msh[7]
    # @patient.p_last_name = @msg.pid[5][1]
    # @patient.p_first_name = @msg.pid[5][2]
    # @patient.diag_code = @msg.pv1[6]
    # @patient.other_test_code = @msg.pv1[7]
    # @patient.phy_last_name = @msg.pv2[10][1]
    # @patient.phy_first_name = @msg.pv2[10][2]
    byebug
    @patient.save
    redirect_to patients_path
  end
end
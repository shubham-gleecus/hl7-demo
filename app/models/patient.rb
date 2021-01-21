# frozen_string_literal: true

# app/models/patient.rb
class Patient < ApplicationRecord
  validates :p_first_name, :phy_last_name, :p_address, :col_name, :col_date, :diag_code,
            :other_test_code, :phy_first_name, :phy_last_name, :phy_email, :clinic_address, presence: true
  before_save :create_hl7

  private

  def create_hl7
    @msg = SimpleHL7::Message.new
    @msg.msh[1] = "|"
    @msg.msh[2] = "^~/&"
    @msg.msh[3] = "hl7-demo"
    @msg.msh[4] = "Instance1"
    @msg.msh[5] = col_name
    @msg.msh[6] = "Instance2"
    @msg.msh[7] = col_date
    @msg.msh[9][1] = "MDM"
    @msg.msh[9][3] = "O01"
    @msg.msh[12] = "2.5.1"
    @msg.pid[1] = id
    @msg.pid[5][1] = p_last_name
    @msg.pid[5][2] = p_first_name
    @msg.pv1[2] = id
    @msg.pv1[4] = col_date
    @msg.pv1[6] = diag_code
    @msg.pv1[7] = other_test_code
    @msg.pv1[10][1] = col_name.split(' ')[1]
    @msg.pv1[10][2] = col_name.split(' ')[0]
    @msg.pv2[10][1] = phy_last_name
    @msg.pv2[10][2] = phy_first_name
    obx1 = @msg.add_segment('obx')
    obx1[3][1] = "WT"
    obx1[3][2] = "WEIGHT"
    obx1[5] = "#{weight}"
    obx1[6] = "KG"
    obx2 = @msg.add_segment('obx')
    obx2[3][1] = "HT"
    obx2[3][2] = "HEIGHT"
    obx2[5] = "#{height}"
    obx2[6] = "cm"
    obx3 = @msg.add_segment('obx')
    obx3[3] = "BMI"
    obx3[5] = "#{bmi}"
    obx4 = @msg.add_segment('obx')
    obx4[3][1] = "P"
    obx4[3][2] = "PULSE"
    obx4[5] = "#{pulse}"
    obx5 = @msg.add_segment('obx')
    obx5[3][1] = "BP"
    obx5[3][2] = "BLOOD-PRESSURE"
    obx5[5] = "#{blood_pressure}"
    @msg.fts[1] = "#{id}"
    @msg.fts[2] = "END OF FILE"
    self.hl_7 = @msg.to_hl7
  end
end
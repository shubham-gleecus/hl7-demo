# frozen_string_literal: true

# app/models/patient.rb
class Patient < ApplicationRecord
  validates :p_name, :p_address, :col_name, :col_date, :diag_code,
            :other_test_code, :phy_name, :phy_email, :clinic_address, presence: true
end
# frozen_string_literal: true

namespace :create do
  desc 'Create Patients'
  # only users with submitting_jv are able to create.
  task patients: :environment do
    Patient.destroy_all
    (10..20).to_a.sample.times do |_n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      name = first_name + ' ' + last_name
      phy_first_name = Faker::Name.first_name
      phy_last_name = Faker::Name.last_name
      phy_name = phy_first_name + ' ' + phy_last_name
      address = Faker::Address.building_number
      address += " #{Faker::Address.secondary_address}"
      address += " #{Faker::Address.building_number}"
      c_address = Faker::Address.building_number
      c_address += " #{Faker::Address.secondary_address}"
      c_address += " #{Faker::Address.building_number}"
      patient = Patient.new(p_first_name: first_name,
                            p_last_name: last_name,
                            p_address: address,
                            col_name: Faker::Name.name,
                            col_date: Faker::Date.between(from: 5.days.ago, to: Date.today),
                            diag_code: Faker::Number.number(digits: 7),
                            other_test_code: Faker::Number.number(digits: 7),
                            phy_first_name: phy_first_name,
                            phy_last_name: phy_last_name,
                            phy_email: "#{phy_name.downcase.split(' ')[0]}@gmail.com",
                            clinic_address: c_address,
                            blood_pressure: "#{(70..200).to_a.sample}/#{(30..130).to_a.sample}",
                            pulse: (50..140).to_a.sample,
                            height: (10..200).to_a.sample,
                            weight: (10..180).to_a.sample,
                            bmi: (15..30).to_a.sample)
      if patient.save
        puts '---- ✅ completed'
      end
    end
  end
end
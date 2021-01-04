# frozen_string_literal: true

namespace :create do
  desc 'Create Patients'
  # only users with submitting_jv are able to create.
  task patients: :environment do
    Patient.destroy_all
    (10..20).to_a.sample.times do |_n|
      name = Faker::Name.name
      phy_name = Faker::Name.name
      address = Faker::Address.building_number
      address += " #{Faker::Address.secondary_address}"
      address += " #{Faker::Address.building_number}"
      patient = Patient.new(p_name: name,
                                     p_address: address,
                                     col_name: Faker::Name.name,
                                     col_date: Faker::Date.between(from: 5.days.ago, to: Date.today),
                                     diag_code: Faker::Number.number(digits: 7),
                                     other_test_code: Faker::Number.number(digits: 7),
                                     phy_name: phy_name,
                                     phy_email: "#{phy_name.downcase.split(' ')[0]}@gmail.com",
                                     clinic_address: address)
      if patient.save
        puts '---- ✅ completed'
      end
    end
  end
end
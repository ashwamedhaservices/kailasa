class User < ApplicationRecord
  validates :mobile_number, 
            :presence => {:message => "Mobile can't be blank." },
            :uniqueness => {:message => "User already registered with this mobile number."}
end

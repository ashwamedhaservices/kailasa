class User < ApplicationRecord
  has_secure_password


  include Users::StateMachine
  include Users::Associatable
  include Users::Validatable
end

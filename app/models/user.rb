class User < ApplicationRecord
  has_secure_password

  include Users::StateMachine
  include Users::Associatable
  include Users::Validatable

  def full_name
    name = "#{fname} #{mname} #{lname}"
    name.blank? ? 'Guest' : "#{title} #{name}".titlecase
  end

  # TODO: temp action
  def token
    ::Kailasa::Jwt.encode({id: id, exp: 1.day.from_now.to_i})
  end
end

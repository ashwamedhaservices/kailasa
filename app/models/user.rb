class User < ApplicationRecord
  include Users::StateMachine
  include Users::Associatable
  include Users::Validatable
  include Users::CallBackable

  def full_name
    name = "#{fname} #{mname} #{lname}"
    name.blank? ? 'Guest' : "#{title} #{name}".titlecase
  end

  # TODO: temp action
  def token
    ::Kailasa::Jwt.encode(id: id, exp: 1.day.from_now.to_i)
  end

  def authenticate(pass)
    password.eql? ::Utils::Password.encrypt(password: pass, salt: salt)
  end
end

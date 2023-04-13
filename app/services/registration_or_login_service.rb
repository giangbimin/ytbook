class RegistrationOrLoginService
  def initialize email, password
    @email = email
    @password = password
  end

  def execute
    user = User.find_by(email: @email)
    error_message = {status: false, error: "Email or password is invalid"}
    if user.present?
      return user.authenticate(@password) ? {status: true, user_id: user.id} : error_message
    end
    user = User.new(email: @email, password: @password)
    return error_message unless user.valid? && user.save
    {status: true, user_id: user.id}
  end
end
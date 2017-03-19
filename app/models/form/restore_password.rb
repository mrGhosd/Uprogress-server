class Form::RestorePassword < Form::Base
  include JsonWebToken
  attr_accessor :token
  attribute :email

  validates :email, presence: true

  def restore
    return unless valid?
    user = ::User.find_by(email: email)
    if user
      @token = generate_token_for_user(user)
      ::UserMailer.delay.restore_password(user, token)
      true
    else
      errors.add(:email, 'There is no such user')
      false
    end
  end
end

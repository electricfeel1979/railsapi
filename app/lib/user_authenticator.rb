# frozen_string_literal: true

class UserAuthenticator
  attr_reader :authenticator, :access_token

  def initialize(code: nil, login: nil, password: nil)
    @authenticator = if code.present?
                       Oauth.new(code)
                     else
                       Standard.new(login, password)
                     end
  end

  def perform
    authenticator.perform

    set_access_token
  end

  delegate :user, to: :authenticator

  private

  def set_access_token
    @access_token = user.access_token.presence || user.create_access_token
  end
end

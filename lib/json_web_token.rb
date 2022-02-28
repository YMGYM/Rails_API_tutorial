class JsonWebToken
  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.credentials.secret_key_base)[0]) # set in rails credentials
  rescue
    nil
  end
end
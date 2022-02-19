class JsonWebToken
  def self.decode(token)
    return HashWithIddifferentAccess.new(JWT.decode(token, ENV["SECRET_KEY_BASE"])[0]) # set in rails credentials
  rescue
    nil
  end
end
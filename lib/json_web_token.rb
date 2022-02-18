class JsonWebToken
  def self.decode(token)
    return HashWithIddifferentAccess.new(JWT.decode(token, ENV["SECRET_KEY_BASE"])[0])
  rescue
    nil
  end
end
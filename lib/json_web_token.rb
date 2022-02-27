class JsonWebToken
  def self.decode(token)
    return HashWithIddifferentAccess.new(JWT.decode(token, ENV["secret_key_base"])[0]) # set in rails credentials
  rescue
    nil
  end
end
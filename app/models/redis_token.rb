class RedisToken

  class << self

    def fetch_token(user_id)
      user_token = Util::Redis.get(key_of_id(user_id))
      user_token || create_token(user_id)
    end

    def create_token(user_id)
      token = generate_token
      Util::Redis.setex(key_of_id(user_id), token)
      Util::Redis.setex(key_of_token(token), user_id)
      token
    end

    def verify_token(token)
      Util::Redis.get(key_of_token(token))
    end

    private

    def generate_token
      loop do
        auth_token = Util::String.friendly_token(32)
        break auth_token unless Util::Redis.get(key_of_token(auth_token))
      end
    end

    def key_of_id(id)
      "user_id:#{id}"
    end

    def key_of_token(token)
      "user_token:#{token}"
    end

  end

end
# -*- encoding : utf-8 -*-

module Util
  class String

    class << self
      def friendly_token(length = 16)
        SecureRandom.base64(length).tr('+/=lIO0', 'xmhesch')
      end
    end

  end
end
# -*- coding: utf-8 -*-

class ErrorCode

  SUCCESS = '0000'

  CODES = {
    success:                       [SUCCESS, '成功'],

    invalid_parameters:            ['1001', '参数不完整'],
    default_system_error:          ['1002', '系统内部错误'],
    invalid_user_token:            ['1003', '验证信息无效，请重新登录'],
    expired_user_token:            ['1004', '验证信息过期，请重新登录']
  }

  class << self

    def default_error
      CODES[:default_system_error]
    end

    def error_content(code)
      if CODES.has_key?(code)
        [false, CODES[code]]
      else
        [false, default_error]
      end
    end

    def error_words(code)
      if CODES.has_key?(code)
        CODES[code].last
      else
        default_error.last
      end
    end

    def error_value(code)
      if CODES.has_key?(code)
        CODES[code]
      else
        default_error
      end
    end

  end
end

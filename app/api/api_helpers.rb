# coding: utf-8
module ApiHelpers

  include Util::GrapeCache

  def render_or_cache(options = {})
    status = options[:status] || '0000'
    message = options[:message] || route.route_description || ''
    content = options[:content] || {}

    set_grape_cache(etag: content)

    { status: status, message: message, content: content }
  end

  def render_json(options = {})
    status = options[:status] || '0000'
    content = options[:content] || {}
    { status: status, content: content }
  end

  def render_error(msg_code)
    status = msg_code.first
    { status: status, content: {} }
  end

  def require_token?
    route.route_params.keys.include?('token')
  end

  def correct_http_status
    case request.request_method.to_s.upcase
    when 'POST'
      201
    else
      200
    end
  end

  # token is required and must be valid
  def validate_token
    return unless require_token?

    if params[:token].blank?
      content = ErrorCode.error_value(:invalid_user_token)
      error!(render_error(content), correct_http_status)
    else
      user_id = RedisToken.verify_token(params[:token])
      if user_id
        params[:user_id] = user_id
      else
        content = ErrorCode.error_value(:expired_user_token)
        error!(render_error(content), correct_http_status)
      end
    end
  end

  # token is optional
  def parse_token
    if params[:token].present?
      params[:user_id] = RedisToken.verify_token(params[:token])
    end
  end

end
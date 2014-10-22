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

  def authentication
    # TODO do request validation
  end

end
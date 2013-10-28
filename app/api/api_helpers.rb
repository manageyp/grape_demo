# coding: utf-8
module ApiHelpers

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
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_error_response message, status = 400
  	response = {status: 'error', message: message}
  	render json: response, status: status
  end

  def render_error_json message, status = 400
    response = {status: 'error', message: message}
    render json: response, status: status
  end

  def render_success_json message, status = 200
    response = {status: 'success', message: message}
    render json: response, status: status
  end
end
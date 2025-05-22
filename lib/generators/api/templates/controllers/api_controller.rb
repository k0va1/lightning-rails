class ApiController < ActionController::API
  include Pagy::Backend

  before_action :set_default_response_format
  wrap_parameters false

  protected

  def set_default_response_format
    request.format = :json
  end
end

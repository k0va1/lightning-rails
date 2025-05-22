module V1
  class BaseController < ::ApiController
    private

    def params
      super.permit!.to_h
    end
  end
end

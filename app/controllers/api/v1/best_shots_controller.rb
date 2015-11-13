module Api::V1
  class BestShotsController < ApiController
    respond_to :json

    def show
      @users = User.where(room_key: params[:id])
    end
  end
end

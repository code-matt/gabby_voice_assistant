# app/controllers/api/v1/campers_controller.rb
class SlideController < ActionController::API
  def index
    click
    render json: {payload: "Success!!"}
  end

  def click
    system("click -x 1000 -y 500")
  end
end

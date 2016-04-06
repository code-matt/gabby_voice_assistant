class UserController < ActionController::API
  def index
    name = get_name(params[:id])
    render json: {speech: "Their name is #{name}"}
  end

  def favorite
    favorites = User.find(params[:id]).favorites
    speech = "#{User.find(params[:id]).name}'s favorite things are '"
    favorites.each do |fav|
      speech += "#{fav.name} and.. "
    end
    render json: {speech: speech}
  end

  def add_fav
    render json: {speech: "Oh shit!.. son"}
  end

  def get_name(id)
    User.find(id).name
  end

end

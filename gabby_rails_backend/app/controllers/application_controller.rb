class ApplicationController < ActionController::Base
  protect_from_forgery


  # CUSTOM EXCEPTION HANDLING
  rescue_from Exception do |e|
    error(e)
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  protected

  def error(e)
    #render :template => "#{Rails::root}/public/404.html"
    # if env["ORIGINAL_FULLPATH"] =~ /^\/api/
    error_info = {
      :error => "Gabby's left_brain does not know about that yet.",
      :exception => "Gabby left_brain does not know about that yet.}",
    }
    error_info[:trace] = e.backtrace[0,10] if Rails.env.development?
    render :json => {gabby_status: "Gabby left_brain does not know about that yet."}, :status => 500
    # else
      #render :text => "500 Internal Server Error", :status => 500 # You can render your own template here
      # raise e
    # end
  end

  # ...

end

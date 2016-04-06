def page_not_found
  respond_to do |format|
    format.json { render json: {error: "Gabby's left_brain does not know about that yet!"} }
  end
end

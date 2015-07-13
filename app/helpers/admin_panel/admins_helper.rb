module AdminPanel::AdminsHelper

  def is_edit_or_update?
    params[:action] == "edit" || params[:action] == "update"
  end

end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title
    if @title.nil?
      "Rails Sample Application"
    else
      @title
    end
  end
end

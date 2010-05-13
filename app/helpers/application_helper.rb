# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title
    if @title.nil?
      "Rails Sample Application"
    else
      @title
    end
  end

  def logo
    image_tag("rails.png", :alt=>"sample App", :class=> "round")
  end

end

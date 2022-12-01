module ApplicationHelper

	def nav_link(controller, link, icon, text)
	  class_name = params[:controller].include?(controller) ? 'nav-item active' : 'nav-item'
	  icon_class = 'fas fa-fw ' + icon

	  content_tag(:li, :class => class_name) do
	    link_to link, class: "nav-link" do
    		concat(content_tag(:i, "", class: icon_class) + " " +
    		content_tag(:span, text))
	    end
	  end
	end

	def header_nav_link(controller, link, text)
	  class_name = params[:controller] == controller ? 'nav-item active' : 'nav-item'

	  content_tag(:li, :class => class_name) do
	    link_to link, class: "nav-link font-14" do
    		concat(content_tag(:i, "") + " " +
    		content_tag(:span, text))
	    end
	  end
	end
end

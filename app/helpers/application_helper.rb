module ApplicationHelper

  def container_class(container)
    if container.present?
      container
    else
      "container"
    end
  end

end

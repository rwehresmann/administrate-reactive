class AdminResourceReflex < StimulusReflex::Reflex
  def destroy
    if requested_resource.destroy
      flash[:notice] = translate_with_resource("destroy.success")
    else
      flash[:error] = requested_resource.errors.full_messages.join("<br/>")
    end
  end

  private

  def requested_resource
    @requested_resource ||= element.signed[:id]
  end
 
  def translate_with_resource(key)
    I18n.t(
      "administrate.controller.#{key}",
      resource: resource_resolver.resource_title,
    )
  end

  def resource_resolver
    @resource_resolver ||= Administrate::ResourceResolver.new(controller_path)
  end

  def controller_path
    request.params.fetch("controller")
  end

  delegate(
    :dashboard_class, 
    :resource_class, 
    :resource_name, 
    :namespace,
    to: :resource_resolver
  )

  def controller_path
    request.params.fetch("controller")
  end

  def dashboard
    @dashboard ||= dashboard_class.new
  end

  def order
    @order ||= Administrate::Order.new(sorting_attribute, sorting_direction)
  end

  def sorting_attribute
    sorting_params.fetch(:order) { default_sorting_attribute }
  end

  def sorting_direction
    sorting_params.fetch(:direction) { default_sorting_direction }
  end

  def sorting_params
    { order: element.dataset.attribute, direction: element.dataset.direction }
  end

  def default_sorting_attribute
    nil
  end

  def default_sorting_direction
    nil
  end

  def controller_class
    ActiveSupport::Inflector.constantize("#{controller_path.split("/").map(&:capitalize).join("::")}Controller")
  end

  def apply_collection_includes(relation)
    resource_includes = dashboard.collection_includes
    return relation if resource_includes.empty?
    relation.includes(*resource_includes)
  end

  def records_per_page
    request.params[:per_page] || 20
  end
end

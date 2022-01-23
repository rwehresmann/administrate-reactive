class CollectionIndexReflex < StimulusReflex::Reflex
  def sort    
    page = Administrate::Page::Collection.new(dashboard, order: order)
    collection_field_name = element.dataset.resource
    resources = element.dataset.resource.singularize.camelize.constantize.all
    resources = apply_collection_includes(resources)
    resources = order.apply(resources)
    resources = resources.page(element.dataset.current_page).per(20)

    morph(
      "#collection-#{element.dataset.resource}", 
      render(
        partial: "admin/application/collection", 
        locals: {
          collection_presenter: page,
          collection_field_name: collection_field_name,
          page: page,
          resources: resources,
          table_title: "page-title"
        }
      )
    )
  end

  private

  def requested_resource
    @requested_resource ||= element.signed[:resource_id]
  end

  def dashboard
    @dashboard ||= dashboard_class.new
  end

  delegate :dashboard_class, to: :resource_resolver

  def resource_resolver
    @resource_resolver ||= Administrate::ResourceResolver.new(controller_path)
  end

  def controller_path
    request.params.fetch("controller")
  end

  def order
    @order ||= Administrate::Order.new(sorting_attribute, sorting_direction)
  end

  def sorting_params
    { order: element.dataset.order, direction: element.dataset.direction }
  end

  def sorting_attribute
    sorting_params.fetch(:order, nil)
  end

  def sorting_direction
    sorting_params.fetch(:direction, nil)
  end

  def apply_collection_includes(relation)
    resource_includes = dashboard.collection_includes
    return relation if resource_includes.empty?
    relation.includes(*resource_includes)
  end
end

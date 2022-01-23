class CollectionShowReflex < StimulusReflex::Reflex
  def sort
    page = Administrate::Page::Show.new(dashboard, parent_resource)
    collection_field_name = element.dataset.resource
    resources = parent_resource.public_send(element.dataset.resource)
    resources = apply_collection_includes(resources)
    resources = order.apply(resources)
    resources = resources.page(element.dataset.current_page).per(5)
    field = Administrate::Field::HasMany.with_options(class_name: resources.first.class.to_s).new(
      resources[1].class.table_name, 
      resources, 
      :show
    )

    morph(
      "#collection-#{parent_resource.class.to_s.underscore}-#{element.dataset.resource}", 
      render(
        partial: "admin/application/collection", 
        locals: {
          collection_presenter: field.associated_collection(order),
          collection_field_name: collection_field_name,
          page: page,
          resources: resources,
          table_title: "page-title"
        }
      )
    )
  end

  private

  def parent_resource
    @requested_resource ||= element.signed[:parent_resource_id]
  end

  def dashboard
    @dashboard ||= dashboard_class.new
  end

  delegate :dashboard_class, to: :resource_resolver

  def resource_resolver
    @resource_resolver ||= Administrate::ResourceResolver.new(controller_path)
  end

  def controller_path
    "admin/#{element.dataset.resource}"
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

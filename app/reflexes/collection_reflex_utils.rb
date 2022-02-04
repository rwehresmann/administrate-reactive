class CollectionReflexUtils
  def initialize(controller_path, element)
    @controller_path = controller_path
    @element = element
  end

  def dashboard
    @dashboard ||= dashboard_class.new
  end

  delegate :dashboard_class, to: :resource_resolver

  def resource_resolver
    @resource_resolver ||= Administrate::ResourceResolver.new(@controller_path)
  end

  def order
    @order ||= Administrate::Order.new(sorting_attribute, sorting_direction)
  end

  def sorting_params
    { order: @element.dataset.order, direction: @element.dataset.direction }
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

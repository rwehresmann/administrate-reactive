class CollectionIndexReflex < StimulusReflex::Reflex
  before_reflex { @utils = CollectionReflexUtils.new(controller_path, element) }
  
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

  delegate(
    :dashboard,
    :apply_collection_includes,
    :order,
    to: :@utils
  )

  def requested_resource
    @requested_resource ||= element.signed[:resource_id]
  end

  def controller_path
    request.params.fetch("controller")
  end
end

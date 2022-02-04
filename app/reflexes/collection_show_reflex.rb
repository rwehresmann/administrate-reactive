class CollectionShowReflex < StimulusReflex::Reflex
  before_reflex { @utils = CollectionReflexUtils.new(controller_path, element) }

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

  delegate(
    :dashboard,
    :apply_collection_includes,
    :order,
    to: :@utils
  )

  def parent_resource
    @requested_resource ||= element.signed[:parent_resource_id]
  end

  def controller_path
    "admin/#{element.dataset.resource}"
  end
end

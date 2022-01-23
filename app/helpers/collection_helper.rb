module CollectionHelper
  # Defines the html data attributes to be used in our collection 
  # reflex classes.
  def self.collection_item_data_attributes(search, collection_field_name, page, resources)
    common_params = {
      resource: collection_field_name,
      direction: search[collection_field_name]["direction"],
      order: search[collection_field_name]["order"],
      current_page: resources.current_page,
    }

    if page.class.to_s == "Administrate::Page::Show"
      common_params.merge({
        controller: "collections-show" , 
        action: "click->collections-show#sort",
        parent_resource_id: page.resource.to_sgid.to_s,
      })
    else
      common_params.merge({
        controller: "collections-index", 
        action: "click->collections-index#sort",
        current_page: resources.current_page,
      })
    end
  end

  # Defines the ID we'll set for the collection <table>.
  def self.collection_id(page, collection_field_name)
    if page.class.to_s == "Administrate::Page::Show"
      "collection-#{page.resource_name}-#{collection_field_name}"
    else
      "collection-#{page.resource_name}"
    end
  end
end

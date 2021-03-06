ActiveAdmin.register Institution do
  permit_params :name, :address, :street, :city, :province, :number, :surface, :workers_count,
                :cuit, :activity, :institutions_count, :contract, :postal_code, :phone_number,
                :longitude, :latitude, :zone_id, :contact, :email, :ciiu, :afip_cod

  controller do
    def destroy
      destroy! do |_success, failure|
        failure.html do
          flash[:error] = 'La acción falló: ' + resource.errors.full_messages.to_sentence
          render action: :index
        end
      end
    end

    # In order to avoid N+1 Query problem
    def scoped_collection
      Institution.includes(:zone)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :cuit
    column :city
    column :province
    column :zone
    actions
  end

  show do # |institution|
    attributes_table do
      row :name
      row :cuit
      row :surface
      row :workers_count
      row :activity
      row :institutions_count
      row :contract
      row :phone_number
      row :address
      row :province
      row :postal_code
      row :zone
      # row :latitude
      # row :longitude
      row :contact
      row :email
      row :ciiu
      row :afip_cod
    end
  end

  form do |f|
    f.inputs 'Institution Details', allow_destroy: true do
      f.semantic_errors(*f.object.errors.keys)
      f.input :name
      f.input :cuit, as: :number
      f.input :street
      f.input :number, as: :number
      f.input :city
      f.input :province, as: :select, collection: ['Capital Federal', 'Buenos Aires'],
                         include_blank: false
      f.input :zone_id, as: :select, collection: Zone.all(&:name), include_blank: false
      f.input :postal_code
      # f.input :address
      # f.input :latitude, as: :number, input_html: { readonly: true }
      # f.input :longitude, as: :number, input_html: { readonly: true }
      f.input :surface, as: :number
      f.input :workers_count, as: :number
      f.input :activity
      f.input :institutions_count, as: :number
      f.input :contract, as: :number
      f.input :phone_number, as: :number
      f.input :contact
      f.input :email
      f.input :ciiu, as: :number
      f.input :afip_cod
    end
    f.actions
  end
end

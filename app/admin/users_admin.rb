# frozen_string_literal: true

Trestle.resource(:users) do
  menu do
    item :users, icon: 'fa fa-star'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :first_name
    column :last_name
    column :email
    column :confirmed, align: :center do |user|
      if user.confirmed?
        status_tag(icon('fa fa-check'), :success)
      else
        status_tag(icon('fa fa-times'), :failure)
      end
    end

    column :roles, align: :center do |user|
      user.roles.collect(&:name).join(', ')
    end
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |_user|
    text_field :email
    row do
      col { text_field :first_name }
      col { text_field :last_name }
    end
    row do
      col { password_field :password }
      col { password_field :password_confirmation }
    end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  params do |params|
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end

class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def link_text
    if approved
      "Unapprove"
    else
      "Approve"
    end
  end

  def link_class
    if approved
      "remove-favorite"
    else
      "shelter-update-top"
    end
  end

  def new_approval_value
    !approved
  end

  def new_adoption_status
    if pet.adoption_status == "Adoptable"
      "Pending"
    else
      "Adoptable"
    end
  end

  def redirect_path_start
    if approved
      "applications"
    else
      "pets"
    end
  end

  def redirect_path_end
    if approved
      application.id
    else
      pet.id
    end
  end
end

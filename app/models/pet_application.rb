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

  def update_approval
    if approved
      approved = false
    else
      approved = true
    end
  end
end

class Contact < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "id_value", "title", "updated_at"]
  end
end

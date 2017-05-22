class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :body_or_image, presence: true

  mount_uploader :image, ImageUploader

  scope :search_new_messaage, ->(id) { where("id > ?", id) }

  private

  def body_or_image
    body.presence or image.presence
  end
end

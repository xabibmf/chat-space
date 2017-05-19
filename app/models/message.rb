class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :body_or_image, presence: true

  mount_uploader :image, ImageUploader

  private

  def body_or_image
    body.presence or image.presence
  end
end

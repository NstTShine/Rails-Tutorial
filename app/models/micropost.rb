class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.microposts.content_max_length}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.microposts.picture_capacity.megabytes
      errors.add(:picture, (t "micropost_validation_picture"))
    end
  end
end

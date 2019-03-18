class Micropost < ApplicationRecord
  belongs_to :user
  scope :sort_by_created_at, ->{order created_at: :desc}
  scope :user_id, ->(id){where "user_id = ?", id}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost_max}
  validate  :picture_size

  private

  def picture_size
    return if picture.size < Settings.picture_size.megabytes
    errors.add(:picture, t("picture_5MB"))
  end
end

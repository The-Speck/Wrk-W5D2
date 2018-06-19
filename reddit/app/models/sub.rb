class Sub < ApplicationRecord
  validates :title, :moderator_id, presence: true
  
  belongs_to :moderator, class: :user
end
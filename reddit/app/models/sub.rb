class Sub < ApplicationRecord
  validates :title, :moderator_id, presence: true
  
  belongs_to :moderator, 
    foreign_key: :moderator_id,    
    class_name: :User
  
  has_many :posts
end
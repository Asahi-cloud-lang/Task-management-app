class Task < ApplicationRecord
  belongs_to :user
  
  validates :work,  presence: true, length: { maximum: 50 }
  validates :detail,  presence: true
end

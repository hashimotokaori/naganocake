class Genre < ApplicationRecord
  has_many :items

  validates :name, {presence: true}
  validates :is_active, inclusion: {in: [true, false]}
end

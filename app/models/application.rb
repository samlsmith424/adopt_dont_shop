class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode 

  enum status: {
    "In Progress" => 0,
    "Pending" => 1,
    "Accepted" => 2,
    "Rejected" => 3
  }
end

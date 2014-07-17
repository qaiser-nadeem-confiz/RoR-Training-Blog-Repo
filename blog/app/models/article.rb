class Article < ActiveRecord::Base
  validates :title, presence: true,
            length: { minimum: 5 }
  validates :text , presence: true , length: {minimum: 10 , maximum: 200}
  has_many :comments , dependent: :destroy
end

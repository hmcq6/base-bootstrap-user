class Slide < ActiveRecord::Base
  attr_accessible :body, :order, :post_id, :timing, :title

  validates :title, length: { maximum: 255 }
  validates :body, presence: true
  
  belongs_to :post
  
end

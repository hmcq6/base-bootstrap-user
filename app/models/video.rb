class Video < ActiveRecord::Base
  attr_accessible :name, :post_id, :url
  
  belongs_to :post
  
end

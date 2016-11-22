class Post < ActiveRecord::Base
	belongs_to :user	
	has_ancestry
	validates :content, :length => { :minimum => 2 }, :presence => true
end

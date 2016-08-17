class Categorization < ActiveRecord::Base
	belongs_to :series
	belongs_to :category
	belongs_to :livestream
	belongs_to :video
end

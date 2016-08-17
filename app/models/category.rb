class Category < ActiveRecord::Base
	has_many :categorizations
	has_many :series, through: :categorizations
	has_many :livestreams, through: :categorizations
	has_many :videos, through: :categorizations
	attr_accessible :name
end

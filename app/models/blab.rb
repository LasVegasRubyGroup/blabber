class Blab < ActiveRecord::Base
	attr_accessible :text
	validates_presence_of :text
	belongs_to :user
end
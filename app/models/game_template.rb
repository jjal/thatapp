class GameTemplate < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :games
end

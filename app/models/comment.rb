class Comment < ActiveRecord::Base
	belongs_to :entry
	validates :user_name, :body, presence: true, length: {minimum: 2}
end
class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :shop
    #after_save :touch_user


    validates :rate, :presence => true,
    :numericality => {:less_than_or_equal_to => 10},
    :numericality => {:greater_than => 1}

		validates :comments, :length => {:within => 3..250},
    :presence => true





    private

   # def touch_user
	#	user.touch
	#end



end

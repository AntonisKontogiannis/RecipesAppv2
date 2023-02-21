class Recipe < ApplicationRecord
    has_many :reviews
    validates :name, presence: true, length: { minimum: 3, maximum: 100}
    validates :orient, presence: true, length: {minimum: 4, maximum: 100}
    validates :instructions, presence: true, length: {minimum: 50, maximum: 100000}
    validates :shape, presence: true, length: {minimum: 4, maximum: 100}
    validates :categories, presence: true
    validates :difficulty, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
    validates :excecution_time, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000}
    validates :portions, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
    has_one_attached :photo
    # validates uniqueness: true

    def reviews_count
        total_reviews = self.reviews.size
        if total_reviews ==  0
            result = 0
        else
            count = 0.0
            self.reviews.each do |review|
                count += review.rating
            end
            result = count/total_reviews
        end
        return result
    end
end

class Blogger < ApplicationRecord
     has_many :posts
     has_many :destinations, through: :posts

     validates :name, presence: true 
     validates :name, uniqueness: true 
     validates :age, presence: true
     validates :age, numericality: { greater_than: 0 }
     # validates :bio, presence: true
     # validates :bio, length: { minimum: 30 }

     def total_likes
          total = self.posts.map do |post|
               post.likes
          end
          total.sum
     end

     def featured_post
          self.posts.order(likes: :desc)[0]
     end

     def top_5_destinations
          destinations = self.posts.group_by do |post|
               post.destination
          end
          sorted = destinations.sort_by do |dest, posts|
               posts.length
          end
          array = sorted.map do |dest|
               dest[0]
          end
          return array[0..4]
     end

end

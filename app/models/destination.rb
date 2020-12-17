class Destination < ApplicationRecord
     has_many :posts
     has_many :bloggers, through: :posts

     def featured_post
          self.posts.order(likes: :desc)[0]
     end


     
     def most_recent_posts
          self.posts.order("created_at desc").limit(5)
     end 



     def average_age
          if self.bloggers.length < 1
               return "There are no posts about this destination yet."
          end
          unique_bloggers = self.bloggers.distinct
          total_age = 0 
          unique_bloggers.each do |blogger|
               total_age += blogger.age 
          end
          average_age = total_age/unique_bloggers.length
          return average_age
     end


 
end

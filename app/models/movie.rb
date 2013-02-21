class Movie < ActiveRecord::Base
  def Movie.get_all_ratings
    all_ratings = []
    self.select(:rating).group(:rating).each do |movie|
      all_ratings << movie.rating
  end
  
  #I was missiing this part
  def sefl.get_all_ratings
    @@all_ratings = ["G","PG","PG-13","R"]
  end

end

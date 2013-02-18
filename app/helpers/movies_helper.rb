module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def highlight?(col)
    @ordered_by == col ? 'hilite' : ''
  end
 
  def checked?(rating)
    @marked_ratings.include? rating unless !@marked_ratings
  end

  def order_params(col)
    {order_by: col, ratings: @marked_ratings}
  end
end

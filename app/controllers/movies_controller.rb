class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_all_ratings

    if(params.has_key?('ratings'))
      @marked_ratings = params[:ratings]
    end

    if(@marked_ratings)
      session[:marked_ratings] = @marked_ratings
    end

    if(params.has_key?('order_by'))
      @ordered_by = params[:order_by]
    end

    if(@ordered_by)
      session[:ordered_by] = @ordered_by
    end

    if(!@marked_ratings && !@ordered_by && session[:marked_ratings])
      @marked_ratings = session[:marked_ratings] unless @marked_ratings
      @ordered_by = session[:ordered_by] unless @ordered_by
      flash.keep
      redirect_to movies_path({order_by: @ordered_by, ratings: @marked_ratings})
    end

    if(@marked_ratings)
      if(@ordered_by)
        @movies = Movie.find_all_by_rating(@marked_ratings, :order => "#{@ordered_by} asc")
      else
        @movies = Movie.find_all_by_rating(@marked_ratings)
      end
    elsif(@ordered_by)
      @movies = Movie.all(:order => "#{@ordered_by} asc")
    else
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end

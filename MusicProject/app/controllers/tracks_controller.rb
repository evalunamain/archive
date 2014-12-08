class TracksController < ApplicationController

  def new
    @track = Track.new(album_id: params[:id])
    @albums = Album.all
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      @albums = Album.all
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      @albums = Album.all
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    album = @track.album_id
    @track.try(:destroy)
    redirect_to album_url(album)
  end

  private
  def track_params
    params.require(:track).permit(:title, :album_id)
  end
end

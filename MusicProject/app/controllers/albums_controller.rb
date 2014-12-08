class AlbumsController < ApplicationController
  def new
    @album = Album.new(band_id: params[:id])
    @bands = Band.all
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      @bands = Band.all
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      @bands = Band.all
      render :edit
    end
  end

  def destroy
    @album.find(params[:id]).try(:destroy)
  end

  private
  def album_params
    params.require(:album).permit(:band_id, :title, :recording_type)
  end
end

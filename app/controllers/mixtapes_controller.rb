class MixtapesController < ApplicationController

  def new
    @mixtape = Mixtape.new

  end

  def create
    @mixtape = Mixtape.new(mixtape_params)


    params[:mixtape][:songs_attributes].each do |index, song_param|
      new_song = Song.new(song_param)
      @mixtape.mixtape_songs.build(:song => new_song)
    end

    @mixtape.add_user(@current_user) if @current_user

    if @mixtape.save
      redirect_to mixtape_path(@mixtape)
    else
      render :new
    end
  end

  def show
    @mixtape = Mixtape.find(params[:id])
    @users = User.all
  end

  def share
    mixtape = Mixtape.find(params[:id])
    user = User.find(params[:user_id])

    if mixtape.add_user(user) && mixtape.save
      redirect_to mixtape_path, notice: "shared!"
    else
      redirect_to mixtape_path, notice: "user already has this mixtape!"
    end

  end


  private
    def mixtape_params
      params.require(:mixtape).permit(:name, :song_ids_to_add => [], :song_attributes => {})
    end

end

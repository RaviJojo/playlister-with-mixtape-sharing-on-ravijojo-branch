class Mixtape < ActiveRecord::Base
  has_many :mixtape_songs
  has_many :songs, :through => :mixtape_songs

  has_many :user_mixtapes
  has_many :users, :through => :user_mixtapes

  accepts_nested_attributes_for :songs

  def song_ids_to_add=(song_ids)
    song_ids.each do |song_id|
      self.mixtape_songs.build(:song_id => song_id)
    end
  end

  def add_user(user)
    if user.mixtapes.include?(self)
      return false
    else
      self.user_mixtapes.build(:user => user)
      return true
    end
  end


end

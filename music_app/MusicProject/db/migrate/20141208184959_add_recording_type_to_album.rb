class AddRecordingTypeToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :recording_type, :string
  end
end

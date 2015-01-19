class NotesController < ApplicationController

  def create
    @note = current_user.notes.new(note_params)
    unless @note.save
      flash[:errors] = @note.errors.full_messages
    end
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.user == current_user
      @note.destroy
      redirect_to :back
    else
      render text: "Not allowed", status: :forbidden
    end
  end

  private
  def note_params
    note_params = params.require(:note).permit(:body, :track_id)
  end
end

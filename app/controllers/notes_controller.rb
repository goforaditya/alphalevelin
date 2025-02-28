class NotesController < ApplicationController
  before_action :require_user
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]

  def index
    @notes = current_user.notes.order(created_at: :desc)
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user

    if @note.save
      flash[:notice] = "Note was successfully created"
      redirect_to @note
    else
      render 'new'
    end
  end

  def update
    if @note.update(note_params)
      flash[:notice] = "Note was successfully updated"
      redirect_to @note
    else
      render 'edit'
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = "Note was successfully deleted"
    redirect_to notes_path
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def require_same_user
    if current_user != @note.user
      flash[:alert] = "You can only view or edit your own notes"
      redirect_to notes_path
    end
  end
end

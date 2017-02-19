class Dashboard::NotesController < Dashboard::DashboardController
  before_action :authenticate_user!
  before_action :find_note, only: [:edit, :update]

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.create(note_params)

    if @note.save
      redirect_to @note
    else
      render `new`
    end
  end

  def edit

  end

  def update

    if @note.update(note_params)
      redirect_to @note
    else
      render 'edit'
    end
  end

  def destroy
    @note = current_user.notes.friendly.find(params[:id])
    @note.destroy

    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(:author, :title, :content, :is_editable,
                                 :link_text, :link_site)
  end

  def find_note
    @note = Note.friendly.find(params[:id])
  end

end

class NotesController < ApplicationController
  def index
    @notes = Note.all.order("created_at asc").paginate(page: params[:page], per_page:3)
  end

  def show
    @note = Note.find(params[:id])
  end
end

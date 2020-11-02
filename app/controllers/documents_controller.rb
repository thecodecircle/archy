class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :restrict_document]
  before_action :restrict_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  # def index
  #   @documents = Document.all
  # end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.user = current_user
    if current_user.admin?
      @document.approved!
    else
      @document.not_approved!
      TeamMailer.notify_document(current_user, @document).deliver_now
    end

    if params[:document][:date].empty?
      @document.date = Date.today
    end

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'המסמך נוצר בהצלחה ומחכה לאישור המנהלות' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:user_id, :content, :description, :title, :date, :privacy, tag_list: [], attachments: [])
    end

    def restrict_document
      redirect_to root_path unless current_user.admin? || @document.commons? || (@document.internal? && current_user.internal?) || (@document.personal? && @document.user_id == current_user.id)
    end
end

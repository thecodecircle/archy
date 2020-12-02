class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy, :restrict_meeting]
  before_action :restrict_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  # def index
  #   @meetings = Meeting.all
  # end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @team = Team.find(params[:team_id])
    @meeting = @team.meetings.new
  end

  # GET /meetings/1/edit
  def edit
    @team = Team.find(params[:team_id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @team = Team.find(params[:team_id])
    @meeting = @team.meetings.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.js {render json: @meeting.id}
        format.json { render :show, status: :created, location: @meeting }
        format.html { redirect_to team_meeting_path(@team, @meeting), notice: 'Meeting was successfully created.' }
      else
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
        format.js
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    @team = Team.find(params[:team_id])
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.js {render json: @meeting.id}
        format.html { redirect_to team_meeting_path(@team, @meeting), notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
        format.js {render json: @meeting.id}
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_meeting
    @meeting = Meeting.find(params[:meeting])
    @user = User.find(params[:user])
    TeamMailer.meeting_email(@meeting, @user).deliver_now
    redirect_to team_meeting_path(@meeting.team, @meeting, sent: "true")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:team_id, :content, :privacy, :subject, tag_list: [], attachments: [], user_ids: [])
    end

    def restrict_meeting
      redirect_to root_path unless current_user.admin? || @meeting.commons? || (@meeting.team? && @meeting.team.users.ids.include?(current_user.id))
    end

end

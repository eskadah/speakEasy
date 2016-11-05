class EventsController < ApplicationController

  before_action :authorized?
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events
    respond_to do |format|
      format.html
      format.json {render json: @events, root: false }
      format.pdf  {render_pdf @events, current_user }
    end
  end

  def new
    @event = Event::AsClick.new(params)
  end

  def create
    @event = current_user.events.build(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
   @event = Event.find(params[:id])
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit

  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private

  def event_params
    params.require(:event).permit(:start, :end, :title, :all_day,:comment)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def render_pdf(events,user)
    pdf = AgendaPDF.new(events,user)
    send_data pdf.render, filename: 'Your Agenda.pdf', type: 'application/pdf'
  end

end

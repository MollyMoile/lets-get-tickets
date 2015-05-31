class MediaController < ApplicationController

  def create
    @medium = MediumForm.new(Medium.new)
    @event = Event.find(medium_params[:event_id])
    if @medium.validate(medium_params)
      @medium.save
      redirect_to event_path(@event)
    else
      render '/events/show'
    end
  end

  private
 
  def medium_params
    params.require(:medium).permit(:url, :event_id)
  end
end

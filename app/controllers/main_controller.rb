class MainController < ApplicationController

  def index
    @tracks = Track.find(:all)
    if !params[:id].nil?
      @current_track = Track.find(params[:id])
    else
      @current_track = Track.find(8)
    end
    @gt_tags = @current_track.gt_tags
    @pred_tags = @current_track.pred_tags
  end

end

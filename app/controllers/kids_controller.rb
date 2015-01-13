class KidsController < ApplicationController
  def new
    @message = flash[:message]
    @flash_style = flash[:success] ? 'alert-success' : 'alert-danger'
  end

  def create
    @kid = Kid.create(kid_params)
    if @kid.id.blank?
      flash[:message] = '<span class="fa fa-exclamation-triangle"></span>Something broke. Try again.'
      flash[:success] = false
    else
      flash[:message] = '<span class="fa fa-check"></span> Got it!'
      flash[:success] = true
    end
    redirect_to root_path
  end

  private
  def kid_params
    params.require(:kid).permit(:image, :net_id, :fname, :lname, :address, :phone)
  end
end

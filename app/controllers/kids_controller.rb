class KidsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        render('index') and return if params[:p].blank?
        @kids = kids_for_page(params[:p])
        render(partial: 'partials/profiles') 
      end
      format.json { render json: kids_for_page(params[:p]) }
    end
  end

  def summary
    render text: 'Password?' and return unless params[:c] == ENV['SUMMARY_ACCESS_CODE']
    @names = Kid.order("LOWER(fname)").pluck(:id, :fname, :nickname, :lname, :is_accepted)
  end

  def new
    @message = flash[:message]
    @flash_style = flash[:success] ? 'alert-success' : 'alert-danger'
  end

  def show
    @kid = Kid.find(params[:id])
    respond_to do |format|
      format.html { render partial: 'partials/card' }
      format.json { render json: @kid }
    end
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

  def update
    @kid = Kid.find(params[:id])
    @kid.is_accepted = is_accepted_param == 'true' ? true : false
    @kid.save
    render json: { is_accepted: @kid.is_accepted }
  end

  private
  def is_accepted_param
    params[:kid][:is_accepted]
  end

  def kid_params
    params.require(:kid).permit(:image, :net_id, :fname, :lname, :nickname, :address, :phone)
  end

  PAGE_SIZE=10
  def unaccepted_kids
    Kid.where(is_accepted: nil)
  end
  def kids_for_page(page)
    page = page.to_i
    (page.blank? || page < 1) ? unaccepted_kids : unaccepted_kids.limit(PAGE_SIZE)
  end
end

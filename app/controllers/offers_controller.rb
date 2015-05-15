class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    @filter = ::Filters::Offer.new user: current_user, subject_id: params[:subject_id]
    @offers = @filter.scope.decorate
  end

  def show
  end

  def new
    @offer = Offer.new
  end

  def edit
  end

  def create
    @offer = Offer.new offer_params

    if @offer.save
      redirect_to offers_path
    else
      render :new
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render action: "edit"
    end
  end

  def destroy
    @offer.destroy

    redirect_to offers_path
  end

  private

  def offer_params
    params.require(:offer).permit(:id, :assignation_id, requested_term_ids: [])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end

class OffersController < ApplicationController
  def index
    @filter = ::Filters::Offer.new user: current_user, subject_id: params[:subject_id]
    @offers = @filter.scope.decorate
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new offer_params

    if @offer.save
      redirect_to offers_path
    else
      render :new
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:id, :assignation_id, requested_term_ids: [])
  end
end

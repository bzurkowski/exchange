class SchedulesController < ApplicationController
  def show
    @schedule = schedule_fetcher.fetch
  end

  private

  def schedule_fetcher
    @schedule_fetcher ||= ScheduleFetcher.new(params[:id])
  end
end

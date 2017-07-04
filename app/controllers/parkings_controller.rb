class ParkingsController < ApplicationController
  def new
    @parking = Parking.new
  end

  def create
    @parking = Parking.new( :start_at => Time.new)
    if current_user
      @parking.parking_type = params[:parking][:parking_type]
      @parking.user = current_user
    else
      @parking.parking_type = "guest"
    end
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def update
    @parking = Parking.find(params[:id])
    @parking.end_at = Time.now
    @parking.calculate_amount
    @parking.save!
    redirect_to parking_path(@parking)
  end
end

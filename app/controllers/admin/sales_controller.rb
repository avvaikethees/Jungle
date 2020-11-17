class Admin::SalesController < ApplicationController
  def index
    #render :index (this is implied when there is nothing else here)
    @sales = Sale.all
  end

end

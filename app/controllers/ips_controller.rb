# IpsController
class IpsController < ApplicationController
  def index
    res = IpReportGenerator.new.call

    respond_to do |format|
      format.json { render json: res[:response], status: res[:status] }
    end
  end
end

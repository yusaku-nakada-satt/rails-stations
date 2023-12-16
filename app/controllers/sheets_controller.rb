class SheetsController < ApplicationController
  def index
    @columns = Sheet.select(:column).distinct
    @rows = Sheet.select(:row).distinct
  end
end

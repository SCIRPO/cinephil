class SeriesController < ApplicationController

    def show
        @serie = Serie.find(params[:id])
    end

end

class SourcesController < ApplicationController

    def index
        @sources = Source.all.paginate(page: params[:page], per_page: 15)
    end

    def show
        @source = Source.find(params[:id])
    end
end

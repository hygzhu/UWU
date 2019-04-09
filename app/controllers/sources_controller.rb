class SourcesController < ApplicationController

    def index

        @filterrific = initialize_filterrific(
            Source,
            params[:filterrific],
            select_options: {
              sorted_by: Source.options_for_sorted_by
            },
            persistence_id: false,
            default_filter_params: { sorted_by: 'year_desc' },
            available_filters: [
              :sorted_by,
              :search_query
            ],
            sanitize_params: true,
          ) || return

        @sources = @filterrific.find.page(params[:page]).per_page(10)
       
        respond_to do |format|
            format.html
            format.js
        end
    end

    def show
        @source = Source.find(params[:id])
    end
end

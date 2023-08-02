module CommonMethods
  extend ActiveSupport::Concern

  included do
    
    # GET /records/new
    def new
    end

    # GET /records/1 or /records/1.json
    def show
    end

    # GET /records/1/edit
    def edit
    end
  end
end
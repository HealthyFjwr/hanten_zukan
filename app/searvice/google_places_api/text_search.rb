module Restaurants
  class TextSearch
    def initialize(keyword)
      @keyword = keyword
    end

    def call
      response = 
    end

    private

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :latitude, :longitude, :is_chain, :is_machi_chuka)
    end
  end
end
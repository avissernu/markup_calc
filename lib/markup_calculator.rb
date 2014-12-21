class MarkupCalculator
    CATEGORY_MARKUP_RATES = Hash[
        :pharmaceuticals => 0.075,
        :food => 0.13,
        :electronics => 0.02,
        :default => 0
    ]
    BASE_MARKUP_RATE = 0.05
    PERSON_MARKUP_RATE = 0.012
    @base_price = nil

    def initialize product
        if !product.respond_to?(:getPrice) || !product.respond_to?(:getCategory) || !product.respond_to?(:getPeople)
            raise 'Product object does not implement proper interface'
        end
        @product = product
    end

    def calcCost precision=2
        @base_price = nil #clear local cache, as it's possible the price in @product changed
        retval = calcBase + calcLabourRate + calcCategoryRate
        return retval.round(precision)
    end

    private
    def calcBase
        if @base_price == nil #some local caching, getPrice could be IO intensive
            orig_price = @product.getPrice
            @base_price = orig_price + (orig_price * BASE_MARKUP_RATE)
        end
        return @base_price
    end

    private
    def calcLabourRate
        return (calcBase * PERSON_MARKUP_RATE) * @product.getPeople
    end

    private
    def calcCategoryRate
        product_category = @product.getCategory.getLabel
        if !CATEGORY_MARKUP_RATES.include?(product_category)
            product_category = :default
        end
        return calcBase * CATEGORY_MARKUP_RATES[product_category]
    end
end

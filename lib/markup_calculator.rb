class MarkupCalculator
    CATEGORY_MARKUP_RATES = Hash[
        "pharm" => 0.075,
        "food" => 0.13,
        "elec" => 0.02,
        "none" => 0
    ]
    BASE_MARKUP_RATE = 0.05
    PERSON_MARKUP_RATE = 0.012
    @base_price = nil

    def initialize product
        @product = product
    end

    def calcCost precision=2
        retval = calcBase + calcLabourRate + calcCategoryRate
        return retval.round(precision)
    end

    def calcBase
        if @base_price == nil
            orig_price = @product.getPrice
            @base_price = orig_price + (orig_price * BASE_MARKUP_RATE)
        end
        return @base_price
    end

    def calcLabourRate
        return (calcBase * PERSON_MARKUP_RATE) * @product.getPeople
    end

    def calcCategoryRate
        return calcBase * CATEGORY_MARKUP_RATES[@product.getCategory]
    end
end

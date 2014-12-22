class MarkupCalculator
    CATEGORY_MARKUP_RATES = Hash[
        :pharmaceuticals => 0.075,
        :food => 0.13,
        :electronics => 0.02,
        :default => 0
    ]
    BASE_MARKUP_RATE = 0.05
    PERSON_MARKUP_RATE = 0.012

    def self.calcCost product, precision=2
        if !product.respond_to?(:getPrice) || !product.respond_to?(:getCategory) || !product.respond_to?(:getPeople)
            raise 'Product object does not implement proper interface'
        end
        orig_price     = product.getPrice
        category_label = product.getCategory.getLabel
        people         = product.getPeople

        markedup_price = self.calcBase(orig_price) + self.calcLabourRate(orig_price, people) + self.calcCategoryRate(orig_price, category_label)
        return markedup_price.round(precision)
    end

    private
    def self.calcBase orig_price
        base_price = orig_price + (orig_price * BASE_MARKUP_RATE)
        return base_price
    end

    private
    def self.calcLabourRate orig_price, people
        return (calcBase(orig_price) * PERSON_MARKUP_RATE) * people
    end

    private
    def self.calcCategoryRate orig_price, category
        # if we don't have a specific markup for this product, let's pick 'default'
        if !CATEGORY_MARKUP_RATES.include?(category)
            category = :default
        end
        return calcBase(orig_price) * CATEGORY_MARKUP_RATES[category]
    end
end

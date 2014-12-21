gem "minitest"
require 'minitest/autorun'
require 'product'

class TestProduct < Minitest::Test
    def setup
        @product = Product.new(123)
    end

    def test_product_price
        assert_respond_to(@product, "getPrice")
        assert_equal 123, @product.getPrice
    end

    def test_product_category
        assert_respond_to(@product, "getCategory")
    end
end

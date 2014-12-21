gem "minitest"
require 'minitest/autorun'
require 'markup_calculator'

class TestMarkupCalculator < Minitest::Test
    def setup
        @product = MiniTest::Mock.new
    end

    def test_calculator_food
        @product.expect(:getPrice, 1299.99)
        @product.expect(:getPeople, 3)
        @product.expect(:getCategory, 'food')
        calculator = MarkupCalculator.new @product
        assert_equal 1591.58, calculator.calcCost
    end

    def test_calculator_pharm
        @product.expect(:getPrice, 5432)
        @product.expect(:getPeople, 1)
        @product.expect(:getCategory, 'pharm')
        calculator = MarkupCalculator.new @product
        assert_equal 6199.81, calculator.calcCost
    end

    def test_calculator_nill
        @product.expect(:getPrice, 12456.95)
        @product.expect(:getPeople, 4)
        @product.expect(:getCategory, 'none')
        calculator = MarkupCalculator.new @product
        assert_equal 13707.63, calculator.calcCost
    end
end

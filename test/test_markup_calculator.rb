gem "minitest"
require 'minitest/autorun'
require 'markup_calculator'

class TestMarkupCalculator < Minitest::Test

    def test_calculator_food
        prod = Product.new(1299.99, 3, 'food')
        calculator = MarkupCalculator.new prod
        assert_equal 1591.58, calculator.calcCost
    end

    def test_calculator_pharm
        prod = Product.new(5432, 1, 'pharm')
        calculator = MarkupCalculator.new prod
        assert_equal 6199.81, calculator.calcCost
    end

    def test_calculator_nill
        prod = Product.new(12456.95, 4)
        calculator = MarkupCalculator.new prod
        assert_equal 13707.63, calculator.calcCost
    end
end

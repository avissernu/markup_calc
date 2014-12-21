gem "minitest"
require 'minitest/autorun'
require 'markup_calculator'

class TestMarkupCalculator < Minitest::Test
    def setup
        @product = MiniTest::Mock.new
    end

    def buildMock price, people, category
        @product.expect(:getPrice, price)
        @product.expect(:getPeople, people)
        category_obj = MiniTest::Mock.new
        category_obj.expect(:getLabel, category)
        @product.expect(:getCategory, category_obj)
    end

    def test_calculator_food
        buildMock 1299.99, 3, :food
        calculator = MarkupCalculator.new @product
        assert_equal 1591.58, calculator.calcCost
    end

    def test_calculator_pharm
        buildMock 5432, 1, :pharmaceuticals
        calculator = MarkupCalculator.new @product
        assert_equal 6199.81, calculator.calcCost
    end

    def test_calculator_books
        buildMock 12456.95, 4, :books
        calculator = MarkupCalculator.new @product
        assert_equal 13707.63, calculator.calcCost
    end

    def test_calculator_precision
        buildMock 999, 2, :electronics
        calculator = MarkupCalculator.new @product
        assert_equal 1095.104, calculator.calcCost(3)
    end

    def test_calculator_fail
        #base mock object doesn't have the appropriate methods
        #  setup so we can pass that and anticipate the exception
        assert_raises (RuntimeError) do
            calculator = MarkupCalculator.new @product
        end
    end
end

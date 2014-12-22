gem "minitest"
require 'minitest/autorun'
require 'markup_calculator'

class TestMarkupCalculator < Minitest::Test
    def setup
        @product = MiniTest::Mock.new
    end

    # Build a mocked up product object, expects to be able to get
    #  a category object from the product object, mock that as well
    def buildMock price, people, category
        return Class.new {
            define_method(:getPrice) { return price }
            define_method(:getPeople) { return people }
            define_method(:getCategory) {
                return Class.new { define_method(:getLabel) { return category }}.new
            }
        }.new
    end

    def test_calculator_food
        mock_product = buildMock 1299.99, 3, :food
        assert_equal 1591.58, MarkupCalculator.calcCost(mock_product)
    end

    def test_calculator_pharm
        mock_product = buildMock 5432, 1, :pharmaceuticals
        assert_equal 6199.81, MarkupCalculator.calcCost(mock_product)
    end

    def test_calculator_books
        mock_product = buildMock 12456.95, 4, :books
        assert_equal 13707.63, MarkupCalculator.calcCost(mock_product)
    end

    def test_calculator_precision
        mock_product = buildMock 999, 2, :electronics
        assert_equal 1095.104, MarkupCalculator.calcCost(mock_product, 3)
    end

    def test_calculator_fail
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(Class.new)
        end
    end

    def test_calculator_fail_on_label
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(Class.new {
                define_method(:getCategory) { return nil }
            }.new)
        end
    end
end

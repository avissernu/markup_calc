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

    def test_calculator_books # tests the non-specific markup code path
        mock_product = buildMock 12456.95, 4, :books
        assert_equal 13707.63, MarkupCalculator.calcCost(mock_product)
    end

    def test_calculator_people_float
        mock_product = buildMock 1000, 1.9, :books
        assert_equal 1073.94, MarkupCalculator.calcCost(mock_product)
    end

    def test_calculator_precision
        mock_product = buildMock 999, 2, :electronics
        assert_equal 1095.104, MarkupCalculator.calcCost(mock_product, 3)
    end

    def test_calculator_invalid_price
        mock_product = buildMock "Nine Hundred, Ninety-Nine", 2, :electronics
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(mock_product)
        end
    end

    def test_calculator_invalid_people
        mock_product = buildMock 999, "two", :electronics
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(mock_product)
        end
    end

    def test_calculator_invalid_precision
        mock_product = buildMock 999, 2, :electronics
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(mock_product, 'Three')
        end
    end

    def test_calculator_invalid_category
        mock_product = buildMock 999, 2, 4
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(mock_product)
        end
    end

    def test_calculator_bad_product_object
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(Class.new)
        end
    end

    def test_calculator_bad_category_object
        assert_raises (RuntimeError) do
            MarkupCalculator.calcCost(Class.new {
                define_method(:getCategory) { return nil }
            }.new)
        end
    end
end

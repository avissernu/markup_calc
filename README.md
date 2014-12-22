### Getting started:
This Module provides a simple markup Calculator that can be used to calculate a markup based on product categories and on amount of labourers invloved with the product.

Basic use of the module requires a product object that implements the a particular interface:
```ruby
    Class Product
        def getPrice
            # ...
            return Float(price)
        end

        def getPeople
            # ...
            return Float(people)
        end

        def getCategory
            # ...
            return category_object
        end
```

The Category Object returned by getCategory should implement the following interface:
```ruby
    Class Category
        def getLabel
            # ...
            return :category_name #symbol of the name of the category
        end
```

### Development:
`bundle install` will get your development environment setup for testing

### Testing:
`rake test` will run tests against the MarkupCalculator ensuring everything is in order

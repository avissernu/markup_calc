class Product

  def initialize(price, people=0, category=nil)
    @price = price
    @category = category
    @people = people
  end

  def getCategory
    return @category
  end

  def getPrice
    return @price
  end

  def getPeople
    return @people
  end
end

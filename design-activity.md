What classes does each implementation include? Are the lists the same?
Each implementation contains the same three classes.

Write down a sentence to describe each class.
class CartEntry: refers to an item with a unit price and a quantity.
class ShoppingCart: refers to the shopping cart that contains many entries.
class Order: refers to the total price of the items in the shopping cart.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
ShoppingCart has a one-to-many relationship with CartEntry. Order has a one-to-one relationship with ShoppingCart. Order has no direct relationship with CartEntry.

What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry stores unit_price and quantity. ShoppingCart stores an array of entries (I assume instances of CartEntry). Order stores a cart (an instance of ShoppingCart).

What methods does each class have? How (if at all) does this differ between the two implementations?
In the first implementation, only the Order has any method. In the second implementation, both CartEntry and ShoppingCart have their own methods to calculate their price, and the Order class has a method to calculate the total_price.

Consider the Order#total_price method. In each implementation:
  Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
 
  In the first implementation, Order retains all the logic to compute the price. In the second implementation, each class is responsible for calculating its own price, and Order uses these calculations to decipher its total price.

  Does total_price directly manipulate the instance variables of other classes?

  In the first implementation, total_price directly accesses the instance variables. Not so in the second implementation.
 
  If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

  The second implementation is easier to modify because we could add a method inside the CartEntry class to calculate the bulk discount.

  Which implementation better adheres to the single responsibility principle?
  Implementation B.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B.

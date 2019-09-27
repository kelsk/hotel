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


ACTIVITY

(Note: I used "refactors.txt" incorrectly by writing the refactors I did while doing my project instead of potential refactors to come back to.)

I believe my code follows the single responsibility principle fairly well. Other than in creating an instance of a class, none of my classes modify the instance variables of another class. My classes for Room, Calendar, Block, and Reservation are all loosely coupled. My Reservation_Manager class is quite stuffed and may have more than one responsibility: creating reservations *and* returning information about reservations and rooms.

Two situations that I think could stand to use a separate class are 1) the method `calculate_total_cost` in both Block and Reservation could be its own class for computing the price, and 2) the helper methods in Reservation_Manager for retrieving information (i.e. `get_rooms_by_id`, `list_reservations_by_date`) could be in a separate class that's strictly for reading information and not manipulating information.

I'm going to choose #2 from above and create two separate classes out of the Reservation_Manager: one to hold the helper methods that retrieve information about the rooms and reservations in the hotel, and one to hold the methods to create reservations. (I'll hopefully refactor the methods themselves along the way.)

The current Reservation_Manager class will hold the informational methods, and the new class Reservation_Creator will hold the actionable methods.

Reservation_Creator will be a child of Reservation_Manager, since it will utilize the same instance variables.

I hope to copy/paste the majority of the code, and then refactor once the new class is functioning and passing all the tests.

---

About halfway into refactoring I deduced that this choice to separate the methods in "Reservation_Manager" was extremely unnecessary. It simply created back-and-forth coupling between the "Reservation_Manager" and the "Reservation_Creator". I do not think this a particularly efficient refactoring. I'm not sure what would be a better solution to the overstuffed ReservationManager class. While that class is technically responsible for more information processing and accessing than the rules of object-oriented design might allow for, I can't come up with a more efficient system of object organization. I would welcome suggestions on what I could have done better.

As a result of this activity, I noticed that my tests were not optimally testing my code. I made some small refactors to a few of them to improve them.

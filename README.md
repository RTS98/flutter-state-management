# Manage State using Value Notifier

## Getting Started

This branch is intended to showcase the way of mananging using **ValueNotifier** class which is based on **Observable Pattern**.

ValueNotifier<T> is a subclass that holds a single value. It is very useful for data types like int, bool, string.
It is also possible for complex data like List, Set or Map, but it won't notify the listeners unless we create a new object. Modifying a value inside the Iterable won't notify the listeners and update accordingly.

It is recommended to create a **ChangeNotifier** for Iterables or Objects.
This branch showcase the way of managing the state via ValueNotfier with a Map.
In this branch you can see that I create a new Map every time we need to rebuild the widget.

In order to update the UI we should use **ValueListenableBuilder** widget.
The main difference between this branch and [feat/vanilla-state-prop-drilling](https://github.com/RTS98/flutter-state-management/tree/feat/vanilla-state-prop-drilling) is that the local copy of the List in CartPage is removed and it's used a ValueNotifier.
Besides that the methods that used to manipulate the local copy are gone now having the logic in only one place.

The duplication for managing the cart page list was removed but methods are still passed from Main Page as arguments making our widgets tightly coupled.
Instead of creating 3 ValueNotifiers for items, total items in the cart and the total price let's create a ChangeNotfier that exposes all these values and methods.
Following this implementation we remove all the business logic from Main Page widget.

Checkout the branch [feat/vanilla-state-change-notifier](https://github.com/RTS98/flutter-state-management/tree/feat/vanilla-state-change-notifier) for a refactored version using **ChangeNotfier** class.

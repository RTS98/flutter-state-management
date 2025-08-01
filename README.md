# Manage State using Lifting the State Up Pattern

## Getting Started

This branch is intended to showcase the way of mananging the state vanilla way.

We have a Product Page that manages the cart and shows and the number of products in the cart.
Cart Page is also able to manange the data itself.
Therefore we need a way to share data between these to independent pages.

**Why not create a global state or a static variable?**

This approach is generraly considered a bad practice for the following reasons: 
- **Global Scope:** Could be modified from everywhere. As the code grows, it is harder and harder to track the places where that variable is modified. 
- **Tight Coupling:** Swapping implementations is harder since the modification should be done in all places instead of 1 place if we follow the encapsulation and abstraction principles of OOP.  
- **Testability:** Having a shared state makes the tests dependent on each other which leads to unstable tests.

The solution is **lifting state up**, a common pattern for dealing with shared data.
Main Page is the chosen parent for both pages and it's role is store the date adn to define the ways to manipulate the data by passing down the methods.
Since Cart Page is also managing the state it has a copy of the products list and propagate changes back to parent via callback.
Immutability is followed by creating a new instance every time instead of modifiying the existing objects.

While this is working fine, we have duplicated logic on Cart Page and Main Page.
Each page is holding its own collection of items.
Imagine that even for this small scenario there is a lot of boilerplate code then for bigger apps it is a pain to maintain such a codebase when some new features are added.

Checkout the branch [feat/vanilla-state-value-notifier](https://github.com/RTS98/flutter-vanilla-state-management/tree/feat/vanilla-state-value-notifier) for a refactored solution using **ValueNotifier** class.

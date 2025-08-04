# Managing State using ChangeNotifier

## Getting Started

[**ChangeNotifier**](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) class that can be extended and provides a change notification API.

This approach encapsulates the business logic from MainPage and exposes multiple fields.
By creating **CartNotifier** class the callbacks are not passed down anymore.
I send the notifier so the number of arguments was reduced to 1 making the widgets less coupled.
If the app grows then it becomes harder to maintain MainPage as long as more and more callback could be added.
The only thing different in the implementation details of _addToCart_ and _removeFromCart_ is the _notifyListeners()_ call.
This method notifies all the listeners(observers) that something has changed.
Here comes the [**ListenableBuilder**](https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html). This widget receives the notifier and builder that is fired everytime with new piece of data.
[**ListenableBuilder**](https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html) is taking care of listeners lifecycle removing this all the boilerplate required for listeners lifecycle.

Now MainPage does not have any business logic. Everything was moved to notifer.
The only thing left here is that the notifier is passed down making this harder to change the entrypoint of the application.
Flutter framework provides a solution for that as well. It's the last type of widget, [**InheritedWidget**](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html).

Check out the branch [feat/vanilla-state-inherited-widget](https://github.com/RTS98/flutter-state-management/tree/feat/vanilla-state-inherited-widget) for a refactored solution using [**InheritedWidget**](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)

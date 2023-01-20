A simple and clean navigation menu.  
  
[![pub package](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
  
| Top Menu | Bottom Menu |
|:--------:|:-----------:|
| [![](https://github.com/lopb/simple_navigation_menu/raw/master/example/assets/top_blue.gif)](https://github.com/lopb/simple_navigation_menu/raw/master/example/lib/main.dart) | [![](https://github.com/lopb/simple_navigation_menu/raw/master/example/assets/bottom_purple.gif)](https://github.com/lopb/simple_navigation_menu/raw/master/example/lib/main.dart) |
  
| Top Menu on a Tablet | Bottom Menu on a Tablet |
|:--------------------:|:-----------------------:|
| [![](https://github.com/lopb/simple_navigation_menu/raw/master/example/assets/top_blue_tablet.png)](https://github.com/lopb/simple_navigation_menu/raw/master/example/lib/main.dart) | [![](https://github.com/lopb/simple_navigation_menu/raw/master/example/assets/bottom_blue_tablet.png)](https://github.com/lopb/simple_navigation_menu/raw/master/example/lib/main.dart) |
  
## Features

Simple menu that can be placed either on top or on bottom of the screens.  
  
You can also pass up to 3 [AppBar Actions](https://api.flutter.dev/flutter/material/AppBar/actions.html) to a screen. Each action will consist of an icon, an icon color and a callback function to br run when the icon is pressed.  
  
## Platform support

| Simple Navigation Menu | Android | iOS | macOS | Web | Windows | Linux |
| ---------------------- | :-----: | :-: | :---: | :-: | :-----: | :---: |
| Compatibility          | ✅      | ✅  | ✅   | ✅  | ✅     | ✅    |
  
## Getting started

Place the SimpleNavHome widget under your MaterialApp's home property and you are good to go.  
  
If you use some state management solution, just wrap the SimpleNavHome widget with your solution, below there is an example using [Provider](https://pub.dev/packages/provider).  
  
You should pass a list of Menu Items (SimpleNavItemModel) to the SimpleNavHome widget, each menu item can receive a title, a screen widget and, optionally, up to 3 actions icons.  
  
## Usage
  
```dart
// Fist you set up the Menu Items, consisting of a String title, a Widget screen and, optionally, up to 3 actions icons.
List<SimpleNavItemModel> _menuItemList() {
  return [
    SimpleNavItemModel(menuItemTitle: 'Menu 1', screen: Container(color: Colors.amber)),
    SimpleNavItemModel(menuItemTitle: 'Menu 2', screen: Container(color: Colors.brown)),
    SimpleNavItemModel(menuItemTitle: 'Menu 3', screen: Container(color: Colors.green)),
  ];
}

// Then you pass the Menu Items to the Navigation Menu, the full list of available parameters are in the examples.
SimpleNavHome(
  titleWidget: const Text('Simple Navigation Menu'),
  appDrawer: const Drawer(child: Center(child: Text("Drawer"))),
  navMenuItemList: _menuItemList(),
  isTopMenu: true,
);
```

```dart
// If you use state management, just wrap everything up like below.
return MultiProvider(
  providers: [
    ListenableProvider<ChangeNofitierOne>(create: (_) => changeNotifierOne),
    ListenableProvider<ChangeNofitierTwo>(create: (_) => changeNotifierTwo),
  ],
  child: const Example(),
);
```
  
For passing actions (icons), see [the example section](https://pub.dev/packages/simple_navigation_menu/example).
  
## Parameters for SimpleNavHome
  
Required:

* **navMenuItemList**: the list of Menu Items to display, each is a SimpleNavItemModel type. The current limit is 10, but you probably shouldn't use more than 6 on a mobile fone, it will not look very good, but all depends on the screen size and the size of the menu's title.
  
Optional:
  
* **titleWidget**: the widget to use as title on AppBar, normally is a Text("String"). The default is SizedBox.shrink().
* **centerTitle**: a bool to define if the title should be centered inside AppBar. The default is false.
* **isTopMenu**: a bool to define if the menu should appear on the top or on the bottom of the screen. The default is true (top).
* **appDrawer**: the drawer Widget to be used, if any. The default is null.
* **initialPageIndex**: a int value for the initial index of the page you want. The default is 0 (first page on the left).
* **frontColorMenu**: a Color value for the front of the menu (text/letters). The default is Colors.white.
* **backColorMenu**: a Color value for the back of the menu (background). The default is Colors.blue.
* **frontColorAppBar**: a Color value for the front of the AppBar (text/letters). The default is Colors.white.
* **backColorAppBar**: a Color value for the back of the AppBar (background). The default is Colors.blue.
  
## Caveats
  
* Drawers are only on the left side of the AppBar, for the moment.
* If your App uses Banner or Native Ads, for the moment you would have to put them on each screen (page) separately, but soon it will be a parameter to SimpleNavHome.
  
## Contributing
  
You can contribute in many ways:
- Fell free to [open issues and report bugs](https://github.com/lopb/simple_navigation_menu/issues).
- Pull requests are welcome!
- English is not my native language, if you find any errors in this documentation then please let me know.
- You can <a href="https://www.buymeacoffee.com/luisbastos">buy me a coffee!</a>
  
<a href="https://www.buymeacoffee.com/luisbastos"><img src="https://github.com/lopb/simple_navigation_menu/raw/master/example/assets/coffee_qr.png" width=400 /></a><a href="https://www.buymeacoffee.com/luisbastos"><img src="https://github.com/lopb/simple_navigation_menu/raw/master/example/assets/coffee.gif" width=300 /></a>
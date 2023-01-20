/// A library to help you use a simple and clean navigation menu.
library simple_nav_menu;

/// Defines the main Widget, [SimpleNavHome]
///
/// Receives most of the user's parameters and provides the final scaffold for the user.
export 'src/widgets/home.dart';

/// Defines the model for a menu item.
///
/// Can be used to instantiate a [SimpleNavItemModel] base model.
/// Contains the item's title widget, screen widget and optional action icons.
export 'src/model/nav_menu_item.dart';

/// Defines optional action Icons in the AppBar
///
/// Can be used to display Icons that behaves accordingly to a callbackFunction.
export 'src/widgets/actions.dart';

import 'package:flutter/material.dart';

import 'package:simple_navigation_menu/src/widgets/actions.dart';

/// Defines the model for a menu item.
///
/// Contains the item's title widget, screen widget and optional action icons.
class SimpleNavItemModel {
  /// The menu item name (String)
  final String menuItemTitle;

  /// The main Widget that will be shown and navigated (swiped)
  final Widget screen;

  /// An optional list of actions (Icons that perform an action via a callbackfunction)
  List<SimpleNavAction>? homeActions;

  /// Takes the required title [menuItemTitle], a widget [screen] and an optional list of actions [homeActions].
  SimpleNavItemModel({required this.menuItemTitle, required this.screen, this.homeActions});
}

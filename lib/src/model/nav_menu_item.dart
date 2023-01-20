import 'package:flutter/material.dart';

import 'package:simple_navigation_menu/src/widgets/actions.dart';

/// Defines the model for a menu item.
///
/// Contains the item's title widget, screen widget and optional action icons.
class SimpleNavItemModel {
  final String menuItemTitle;
  final Widget screen;
  List<SimpleNavAction>? homeActions;
  SimpleNavItemModel(
      {required this.menuItemTitle, required this.screen, this.homeActions});
}

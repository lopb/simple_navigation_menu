import 'package:flutter/material.dart';

import 'package:simple_navigation_menu/src/widgets/menu_item.dart';
import 'package:simple_navigation_menu/src/model/nav_menu_item.dart';

/// Defines a Widget for the menu accordingly to the user's parameters.
class SimpleNavMenu extends StatelessWidget {
  final PageController controller;
  final int currentPage;
  final List<SimpleNavItemModel> navMenuItemList;
  final Color frontColorMenu;
  final Color backColorMenu;
  final bool isTopMenu;
  const SimpleNavMenu({
    super.key,
    required this.controller,
    required this.currentPage,
    required this.navMenuItemList,
    required this.frontColorMenu,
    required this.backColorMenu,
    required this.isTopMenu,
  });

  // Adapts the widget to be on the bottom or the top.
  EdgeInsets _getPadding() {
    if (isTopMenu == true) {
      return const EdgeInsets.only(bottom: 1);
    } else {
      return const EdgeInsets.only(top: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _getPadding(),
      color: backColorMenu,
      child: Row(
        crossAxisAlignment:
            isTopMenu ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: navMenuItemList
            .map((e) => SimpleNavMenuItem(
                menuItemTitle: e.menuItemTitle,
                itemIndex: navMenuItemList.indexOf(e),
                currentPage: currentPage,
                controller: controller,
                frontColor: frontColorMenu,
                isTopMenu: isTopMenu))
            .toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:simple_navigation_menu/src/model/nav_menu_item.dart';

/// Controls the screen beeing shown to the user.
class SimpleNavPageView extends StatelessWidget {
  final PageController controller;
  final List<SimpleNavItemModel> navMenuItemList;
  const SimpleNavPageView(
      {super.key, required this.controller, required this.navMenuItemList});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = navMenuItemList.map((e) => e.screen).toList();
    return Expanded(
      child: PageView(
        controller: controller,
        children: pages,
      ),
    );
  }
}

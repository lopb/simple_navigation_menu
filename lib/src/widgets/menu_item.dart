// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Defines a Widget for each of the menu's items.
class SimpleNavMenuItem extends StatelessWidget {
  final String menuItemTitle;
  final int itemIndex;
  final int currentPage;
  final PageController controller;
  final Color frontColor;
  final bool isTopMenu;
  final double textScaleFactor;
  const SimpleNavMenuItem({
    super.key,
    required this.menuItemTitle,
    required this.itemIndex,
    required this.currentPage,
    required this.controller,
    required this.frontColor,
    required this.isTopMenu,
    required this.textScaleFactor,
  });

  /// Adapts the widget to be on the bottom or the top.
  EdgeInsets _getPadding() {
    if (isTopMenu) {
      return const EdgeInsets.only(bottom: 10, top: 15);
    } else {
      return const EdgeInsets.only(bottom: 15, top: 10);
    }
  }

  /// Adapts the widget to be on the bottom or the top.
  Border _getBorder() {
    BorderSide borderSide = BorderSide(width: 6, color: frontColor);
    if (isTopMenu == true) {
      return Border(bottom: borderSide);
    } else {
      return Border(top: borderSide);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Cubic curve = Curves.easeInOutCubic;
    const Duration duration = Duration(milliseconds: 300);
    final bool isItemSelected = (currentPage == itemIndex) ? true : false;
    return Expanded(
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (!isItemSelected) {
            controller.animateToPage(itemIndex,
                curve: curve, duration: duration);
          }
        },
        child: Container(
          padding: _getPadding(),
          decoration:
              isItemSelected ? BoxDecoration(border: _getBorder()) : null,
          child: Text(menuItemTitle,
              style: TextStyle(
                color: frontColor,
                fontWeight:
                    isItemSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textScaleFactor: isItemSelected ? textScaleFactor : 1.0,
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

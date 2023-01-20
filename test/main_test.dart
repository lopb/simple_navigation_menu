import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_navigation_menu/simple_navigation_menu.dart';

void main() {
  test('Main test', () {
    const SimpleNavHome simpleNavHome = SimpleNavHome(
      titleWidget: Text(""),
      appDrawer: Drawer(),
      navMenuItemList: [],
      frontColorAppBar: Colors.white,
      backColorAppBar: Colors.blue,
      frontColorMenu: Colors.white,
      backColorMenu: Colors.blue,
      isTopMenu: false,
    );
    expect(simpleNavHome.isTopMenu, false);
  });
}

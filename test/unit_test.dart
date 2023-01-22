import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_navigation_menu/simple_navigation_menu.dart';

void main() {
  group('Unit tests', () {
    test('SimpleNavItemModel has an optional homeActions', () {
      SimpleNavItemModel simpleNavItemModel = SimpleNavItemModel(
        menuItemTitle: '',
        screen: const SizedBox.shrink(),
      );
      expect(simpleNavItemModel.homeActions, null);
    });
  });
}

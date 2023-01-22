import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_navigation_menu/simple_navigation_menu.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
Container myAd = Container(color: Colors.purple, child: const Text("Ad Text"));
Text myAppTitle = const Text("Simple Navigation Menu");

saveCallback() async {
  const snackBar = SnackBar(
      content: Text("Saved (example)"), duration: Duration(seconds: 2));
  snackbarKey.currentState?.showSnackBar(snackBar);
}

List<SimpleNavAction> getHomeActions() {
  return [
    const SimpleNavAction(iconData: Icons.save, callbackFunction: saveCallback),
  ];
}

List<SimpleNavAction> getMultipleHomeActions(int actionSize) {
  return List.generate(
      actionSize,
      (index) =>
          SimpleNavAction(iconData: Icons.save, callbackFunction: () {}));
}

List<SimpleNavItemModel> getNavMenuItemList() {
  return [
    SimpleNavItemModel(
        menuItemTitle: 'Menu 1',
        screen: Container(color: Colors.amber, child: const Text("Page 1"))),
    SimpleNavItemModel(
        menuItemTitle: 'Menu 2',
        screen: Container(color: Colors.green, child: const Text("Page 2")),
        homeActions: getHomeActions()),
  ];
}

List<SimpleNavItemModel> getNavMenuItemListMultipleActions(int actionSize) {
  return [
    SimpleNavItemModel(
        menuItemTitle: 'Menu 1',
        screen: Container(color: Colors.amber, child: const Text("Page 1")),
        homeActions: getMultipleHomeActions(actionSize)),
  ];
}

List<SimpleNavItemModel> getMultipleMenuItems(int menuSize) {
  return List.generate(
    menuSize,
    (index) => SimpleNavItemModel(
        menuItemTitle: 'Menu ${(index + 1)}',
        screen:
            Container(color: Colors.amber, child: Text("Page ${index + 1}")),
        homeActions: getHomeActions()),
  );
}

Finder screen1Finder =
    find.ancestor(of: find.text("Page 1"), matching: find.byType(Container));
Finder screen2Finder =
    find.ancestor(of: find.text("Page 2"), matching: find.byType(Container));
Finder menu1Finder =
    find.ancestor(of: find.text("Menu 1"), matching: find.byType(InkWell));
Finder menu2Finder =
    find.ancestor(of: find.text("Menu 2"), matching: find.byType(InkWell));
Finder menu10Finder =
    find.ancestor(of: find.text("Menu 10"), matching: find.byType(InkWell));
Finder menu11Finder =
    find.ancestor(of: find.text("Menu 11"), matching: find.byType(InkWell));
Finder menuEmptyFinder =
    find.ancestor(of: find.text("Empty List"), matching: find.byType(InkWell));
Finder pageViewFinder =
    find.ancestor(of: find.byType(Container), matching: find.byType(PageView));
Finder actionFinder =
    find.ancestor(of: find.byType(Icon), matching: find.byType(InkWell));
Finder adFinder =
    find.ancestor(of: find.text("Ad Text"), matching: find.byType(Container));
Finder snackbarFinder = find.textContaining("Saved (example)");

void main() {
  group('Widget tests', () {
    testWidgets(
        'Home Widget :: From index 0 to 1 and 1 to 0 using tapping the menu items',
        (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = SimpleNavHome(
        navMenuItemList: getNavMenuItemList(),
      );
      await tester.pumpWidget(MaterialApp(home: simpleNavHome));

      expect(screen1Finder, findsOneWidget);

      await tester.tap(menu2Finder);
      await tester.pumpAndSettle();
      expect(screen2Finder, findsOneWidget);

      await tester.tap(menu1Finder);
      await tester.pumpAndSettle();
      expect(screen1Finder, findsOneWidget);
    });

    testWidgets(
        'Home Widget :: From index 0 to 1 and 1 to 0 using swipe gesture (drag)',
        (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = SimpleNavHome(
        navMenuItemList: getNavMenuItemList(),
      );
      await tester.pumpWidget(MaterialApp(home: simpleNavHome));

      await tester.dragUntilVisible(
          screen2Finder, pageViewFinder, const Offset(-250, 0));
      await tester.pumpAndSettle();
      expect(screen2Finder, findsOneWidget);

      await tester.dragUntilVisible(
          screen1Finder, pageViewFinder, const Offset(250, 0));
      await tester.pumpAndSettle();
      expect(screen1Finder, findsOneWidget);
    });

    testWidgets('Home Widget :: From index 0 to 1 and tap the save action icon',
        (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = SimpleNavHome(
        titleWidget: myAppTitle,
        appDrawer: const Drawer(),
        navMenuItemList: getNavMenuItemList(),
      );
      await tester.pumpWidget(
          MaterialApp(home: simpleNavHome, scaffoldMessengerKey: snackbarKey));

      await tester.tap(menu2Finder);
      await tester.pumpAndSettle();
      expect(screen2Finder, findsOneWidget);

      await tester.tap(actionFinder);
      await tester.pumpAndSettle();
      expect(snackbarFinder, findsOneWidget);
    });

    testWidgets('Home Widget :: Empty Menu Items', (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = const SimpleNavHome(
        navMenuItemList: [],
        isTopMenu: false,
        isTopAd: false,
      );
      await tester.pumpWidget(MaterialApp(home: simpleNavHome));

      expect(menuEmptyFinder, findsOneWidget);
    });

    testWidgets('Home Widget :: More than 10 Menu Items (12)',
        (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = SimpleNavHome(
        navMenuItemList: getMultipleMenuItems(12),
        isTopMenu: true,
        isTopAd: true,
      );
      await tester.pumpWidget(MaterialApp(home: simpleNavHome));

      expect(menu10Finder, findsOneWidget);
      expect(menu11Finder, findsNothing);
    });

    testWidgets('Home Widget :: More than 3 Action Icons',
        (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = SimpleNavHome(
        titleWidget: myAppTitle,
        appDrawer: const Drawer(),
        navMenuItemList: getNavMenuItemListMultipleActions(4),
        isTopMenu: false,
        isTopAd: true,
      );
      await tester.pumpWidget(MaterialApp(home: simpleNavHome));

      expect(actionFinder, findsNWidgets(3));
    });

    testWidgets('Home Widget :: tests initialPageIndex',
        (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = SimpleNavHome(
        navMenuItemList: getNavMenuItemList(),
        initialPageIndex: 1,
      );
      await tester.pumpWidget(MaterialApp(home: simpleNavHome));

      expect(screen2Finder, findsOneWidget);
    });

    testWidgets('Home Widget :: tests ad default height',
        (WidgetTester tester) async {
      SimpleNavHome simpleNavHome = SimpleNavHome(
        titleWidget: myAppTitle,
        appDrawer: const Drawer(),
        navMenuItemList: getNavMenuItemList(),
        isTopMenu: true,
        isTopAd: false,
        ad: myAd,
      );
      await tester.pumpWidget(MaterialApp(home: simpleNavHome));

      Size adSize = tester.getSize(adFinder.first);
      expect(adSize.height, equals(50.0));
    });
  });
}

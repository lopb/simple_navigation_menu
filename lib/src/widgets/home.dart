import 'package:flutter/material.dart';

import 'package:simple_navigation_menu/simple_navigation_menu.dart';
import 'package:simple_navigation_menu/src/model/nav_menu_item.dart';
import 'package:simple_navigation_menu/src/widgets/menu.dart';
import 'package:simple_navigation_menu/src/widgets/page_view.dart';

/// Receives most of the user's parameters and provides the final scaffold for the user.
class SimpleNavHome extends StatefulWidget {
  final Widget? titleWidget;
  final Widget? appDrawer;
  final List<SimpleNavItemModel> navMenuItemList;
  final bool? isTopMenu;
  final bool? centerTitle;
  final int? initialPageIndex;
  final Color? frontColorMenu;
  final Color? backColorMenu;
  final Color? frontColorAppBar;
  final Color? backColorAppBar;
  const SimpleNavHome({
    Key? key,
    this.titleWidget,
    this.appDrawer,
    required this.navMenuItemList,
    this.isTopMenu,
    this.centerTitle,
    this.initialPageIndex,
    this.frontColorMenu,
    this.backColorMenu,
    this.frontColorAppBar,
    this.backColorAppBar,
  }) : super(key: key);
  @override
  State<SimpleNavHome> createState() => _SimpleNavHomeState();
}

/// Defines the [SimpleNavHome] state.
class _SimpleNavHomeState extends State<SimpleNavHome>
    with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  late final PageController _controller;
  late bool centerTitle;
  late bool isTopMenu;
  late Color frontColorMenu;
  late Color backColorMenu;
  late Color frontColorAppBar;
  late Color backColorAppBar;
  late Widget titleWidget;
  late int initialPageIndex;
  late List<SimpleNavItemModel> navMenuItemList;
  static const int maxMenuSize = 10;
  static const int maxActionSize = 3;

  // Defines a menu item to show if user passed an empty list.
  final SimpleNavItemModel emptyNavItem =
      SimpleNavItemModel(menuItemTitle: "Empty List", screen: Container());

  @override
  void initState() {
    super.initState();
    _initVariables();
    _initPageController();
    _checkMaxSize();
  }

  /// Initializes variables.
  void _initVariables() {
    frontColorMenu = widget.frontColorMenu ?? Colors.white;
    backColorMenu = widget.backColorMenu ?? Colors.blue;
    frontColorAppBar = widget.frontColorAppBar ?? Colors.white;
    backColorAppBar = widget.backColorAppBar ?? Colors.blue;
    isTopMenu = widget.isTopMenu ?? true;
    titleWidget = widget.titleWidget ?? const SizedBox.shrink();
    centerTitle = widget.centerTitle ?? false;
    widget.navMenuItemList.isEmpty
        ? navMenuItemList = [emptyNavItem]
        : navMenuItemList = widget.navMenuItemList;
    initialPageIndex = widget.initialPageIndex ?? _currentPage;
    _currentPage = initialPageIndex;
    if (initialPageIndex < 0) _currentPage = 0;
    if (initialPageIndex > (widget.navMenuItemList.length - 1)) {
      _currentPage = widget.navMenuItemList.length - 1;
    }
  }

  /// Initializes the [_currentPage] and the [_controller] values, then rebuilds the widget.
  void _initPageController() {
    _controller = PageController(initialPage: initialPageIndex);
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.round() ?? _currentPage;
      });
    });
  }

  /// Limits the usage of the widget to at most [maxMenuSize] menu items.
  ///
  /// Limits the usage of the widget to at most [maxActionSize] actions (icons in the AppBar that do something).
  void _checkMaxSize() {
    navMenuItemList = navMenuItemList.take(maxMenuSize).toList();
    for (var menuItem in navMenuItemList) {
      if (menuItem.homeActions != null) {
        menuItem.homeActions =
            menuItem.homeActions?.take(maxActionSize).toList();
      }
    }
  }

  /// Defines the body of the screen as been the [SimpleNavMenu] and the [SimpleNavPageView]
  ///
  /// Reverses the order if [isTopMenu] is false, so the [SimpleNavMenu] stays on the bottom.
  List<Widget> _getBodyColumnChildren() {
    List<Widget> bodyColumnChildren = [
      SimpleNavMenu(
        controller: _controller,
        currentPage: _currentPage,
        navMenuItemList: navMenuItemList,
        isTopMenu: isTopMenu,
        frontColorMenu: frontColorMenu,
        backColorMenu: backColorMenu,
      ),
      SimpleNavPageView(
          controller: _controller, navMenuItemList: navMenuItemList),
    ];
    if (isTopMenu == false) {
      bodyColumnChildren = bodyColumnChildren.reversed.toList();
    }
    return bodyColumnChildren;
  }

  Widget _body() {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: _getBodyColumnChildren(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: centerTitle,
        title: titleWidget,
        actions: navMenuItemList.elementAt(_currentPage).homeActions,
        foregroundColor: frontColorAppBar,
        backgroundColor: backColorAppBar,
        elevation: isTopMenu ? 0 : null,
      ),
      drawer: widget.appDrawer,
      body: _body(),
    );
  }
}

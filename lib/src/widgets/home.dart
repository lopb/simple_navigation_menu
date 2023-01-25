import 'package:flutter/material.dart';

import 'package:simple_navigation_menu/simple_navigation_menu.dart';
import 'package:simple_navigation_menu/src/model/nav_menu_item.dart';
import 'package:simple_navigation_menu/src/widgets/menu.dart';
import 'package:simple_navigation_menu/src/widgets/page_view.dart';

/// Receives most of the user's parameters and provides the final scaffold for the user.
class SimpleNavHome extends StatefulWidget {
  /// Title to appear on the AppBar, can be any Widget but normally is a Text("String"). The default is SizedBox.shrink().
  final Widget? titleWidget;

  /// The drawer Widget to be used, if any. The default is null.
  final Widget? appDrawer;

  /// The list of Menu Items to display, each is a SimpleNavItemModel type. The current limit is 10, but you probably shouldn't use more than 6 on a mobile fone, it won't look very good, but all depends on the screen size and the size of the menu's title.
  final List<SimpleNavItemModel> navMenuItemList;

  /// Defines if the menu should appear on the top or on the bottom of the screen. The default is true (top).
  final bool? isTopMenu;

  /// Defines if the title should be centered inside AppBar. The default is false.
  final bool? centerTitle;

  /// The initial index of the page you want. The default is 0 (first page on the left).
  final int? initialPageIndex;

  /// A Color value for the front of the menu (text/letters). The default is Colors.white.
  final Color? frontColorMenu;

  /// A Color value for the back of the menu (background). The default is Colors.blue.
  final Color? backColorMenu;

  /// A Color value for the front of the AppBar (text/letters). The default is Colors.white.
  final Color? frontColorAppBar;

  /// A Color value for the back of the AppBar (background). The default is Colors.blue.
  final Color? backColorAppBar;

  /// Defines if the Ad should appear on the top or on the bottom of the screen. The default is false (bottom).
  final bool? isTopAd;

  /// A Widget to show as an Ad in all of the menu's screens. Normally an AdWidget instance. The default is null (doesn't show anything).
  final Widget? ad;

  /// A Color value for the background of the Ad. The default is Colors.blue.
  final Color? adBackColor;

  /// The Ad's height. The default is 50.0.
  final double? adHeight;

  /// Sets how much "zoom" is applied to the selected menu item. The default is 1.15 (15% larger than normal).
  final double? textScaleFactor;

  /// Takes the required and options parameters that later will be initialized in the initState.
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
    this.isTopAd,
    this.ad,
    this.adBackColor,
    this.adHeight,
    this.textScaleFactor,
  }) : super(key: key);
  @override
  State<SimpleNavHome> createState() => _SimpleNavHomeState();
}

/// Defines the [SimpleNavHome] state.
class _SimpleNavHomeState extends State<SimpleNavHome> with SingleTickerProviderStateMixin {
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
  late bool isTopAd;
  late Color adBackColor;
  late double adHeight;
  late double textScaleFactor;
  late List<SimpleNavItemModel> navMenuItemList;
  static const int maxMenuSize = 10;
  static const int maxActionSize = 3;
  static const double adDefaultHeight = 50.0;

  /// Defines a menu item to show if user passed an empty list.
  final SimpleNavItemModel emptyNavItem = SimpleNavItemModel(menuItemTitle: "Empty List", screen: Container());

  @override
  void initState() {
    super.initState();
    _initVariables();
    _initPageIndex();
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
    widget.navMenuItemList.isEmpty ? navMenuItemList = [emptyNavItem] : navMenuItemList = widget.navMenuItemList;
    isTopAd = widget.isTopAd ?? false;
    adBackColor = widget.adBackColor ?? Colors.blue;
    adHeight = widget.adHeight ?? adDefaultHeight;
    textScaleFactor = widget.textScaleFactor ?? 1.15;
  }

  /// Initializes the page indexes and mitigates some abnormal states.
  void _initPageIndex() {
    initialPageIndex = widget.initialPageIndex ?? _currentPage;
    if (initialPageIndex < 0) {
      initialPageIndex = 0;
    }
    if (initialPageIndex > (navMenuItemList.length - 1)) {
      initialPageIndex = navMenuItemList.length - 1;
    }
    _currentPage = initialPageIndex;
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
        menuItem.homeActions = menuItem.homeActions?.take(maxActionSize).toList();
      }
    }
  }

  /// Defines the body of the screen as been the [SimpleNavMenu] and the [SimpleNavPageView]
  ///
  /// Defines the order of the Widgets, the menu and the ad can be top or down, resulting in 4 different combinations.
  List<Widget> _getBodyColumnChildren() {
    /// Sets the Ad's Container height to 0 if Ad is null. The default is 50.0.
    Container adContainer = Container(
      height: widget.ad == null ? 0 : adHeight,
      color: adBackColor,
      child: widget.ad ?? const SizedBox.shrink(),
    );
    SimpleNavMenu menu = SimpleNavMenu(
      controller: _controller,
      currentPage: _currentPage,
      navMenuItemList: navMenuItemList,
      isTopMenu: isTopMenu,
      frontColorMenu: frontColorMenu,
      backColorMenu: backColorMenu,
      textScaleFactor: textScaleFactor,
    );
    SimpleNavPageView pageView = SimpleNavPageView(controller: _controller, navMenuItemList: navMenuItemList);
    if (isTopMenu && isTopAd) {
      return [menu, adContainer, pageView];
    } else if (isTopMenu && !isTopAd) {
      return [menu, pageView, adContainer];
    } else if (!isTopMenu && isTopAd) {
      return [adContainer, pageView, menu];
    } else {
      return [pageView, adContainer, menu];
    }
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
        elevation: isTopMenu || isTopAd ? 0 : null,
      ),
      drawer: widget.appDrawer,
      body: _body(),
    );
  }
}

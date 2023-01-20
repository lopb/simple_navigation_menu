import 'package:flutter/material.dart';
import 'package:simple_navigation_menu/simple_navigation_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});
  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Widget _getExampleScreen(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Scaffold newScaffold = Scaffold(
                appBar: AppBar(),
                body: Container(
                    color: Colors.white,
                    child: const Center(child: Text("Child page"))));
            final route = MaterialPageRoute(builder: (context) => newScaffold);
            Navigator.push(context, route);
          },
          child: Text(text,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  List<SimpleNavItemModel> _getNavMenuItemList() {
    return [
      SimpleNavItemModel(
          menuItemTitle: 'Menu 1',
          screen: _getExampleScreen(Colors.amber, "Page 1")),
      SimpleNavItemModel(
          menuItemTitle: 'Menu 2',
          screen: _getExampleScreen(Colors.green, "Page 2"),
          homeActions: _getHomeActions()),
      SimpleNavItemModel(
          menuItemTitle: 'Menu 3',
          screen: _getExampleScreen(Colors.pink, "Page 3")),
      SimpleNavItemModel(
          menuItemTitle: 'Menu 4',
          screen: _getExampleScreen(Colors.brown, "Page 4")),
      SimpleNavItemModel(
          menuItemTitle: 'Menu 5',
          screen: _getExampleScreen(Colors.grey, "Page 5")),
    ];
  }

  List<SimpleNavAction> _getHomeActions() {
    return [
      SimpleNavAction(iconData: Icons.save, callbackFunction: _saveCallback),
      SimpleNavAction(
          iconData: Icons.cleaning_services_outlined,
          callbackFunction: _clearCallback),
    ];
  }

  _saveCallback() async {
    const snackBar = SnackBar(
        content: Text("Saved (example)"), duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _clearCallback() async {
    var confirmation = await _showExampleConfirmation(context) ?? false;
    if (confirmation != null &&
        confirmation is bool &&
        confirmation &&
        mounted) {
      const snackBar = SnackBar(
          content: Text("Cleared (example)"), duration: Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static _showExampleConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation Example"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Confirm"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleNavHome(
      titleWidget: const Text('Simple Navigation Menu'),
      appDrawer: const Drawer(child: Center(child: Text("Drawer"))),
      navMenuItemList: _getNavMenuItemList(),
      isTopMenu: true,
    );
  }
}

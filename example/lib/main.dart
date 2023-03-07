import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_navigation_menu/simple_navigation_menu.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  // The next two lines (initializations) are there because of the Ad usage.
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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

// The _bannerAd, initState and dispose are only needed because of the Ad usage, so, if you don't plan on using any Ads, ignore them.
class _ExampleState extends State<Example> {
  BannerAd? _bannerAd;

  @override
  initState() {
    super.initState();
    AdHelper.initAds((ad) {
      setState(() {
        _bannerAd = ad as BannerAd;
      });
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

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

  // A simple example of a callback function that will be called when the Action (AppBar Icon) will be pressed.
  _saveCallback() async {
    const snackBar = SnackBar(
        content: Text("Saved (example)"), duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // A simple example of a callback function that will be called when the Action (AppBar Icon) will be pressed.
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

  // Just a showDialog that will be called when you confirm an action. Nothing too relevant for your real world app.
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
      isTopAd: false,
      ad: _bannerAd != null ? AdWidget(ad: _bannerAd!) : null,
    );
  }
}

// Helper Class to make it easier to use Ads.
//
// In case you want to adapt this Class for your app, remember to also copy the changes made to AndroidManifest.xml and Info.plist.
class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static initAds(Function(Ad) initAdCallback) {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: initAdCallback,
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }
}

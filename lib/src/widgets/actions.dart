import 'package:flutter/material.dart';

/// Defines optional action Icons in the AppBar
///
/// Can be used to display Icons that behaves accordingly to a callbackFunction.
class SimpleNavAction extends StatelessWidget {
  /// The icon that will be used for this Action (ex: Icons.house)
  final IconData iconData;

  /// The function that will be performed when the user taps on the icon.
  final Function() callbackFunction;

  /// The optional color to be used on the defined icon. The default value is Colors.white.
  final Color? iconColor;

  /// Takes the required icon [iconData], a function [callbackFunction] and an optional color for the icon [iconColor].
  const SimpleNavAction(
      {super.key,
      required this.iconData,
      required this.callbackFunction,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: callbackFunction,
        customBorder: const CircleBorder(),
        child: Icon(iconData, size: 26, color: iconColor ?? Colors.white),
      ),
    );
  }
}

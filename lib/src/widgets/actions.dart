import 'package:flutter/material.dart';

/// Defines optional action Icons in the AppBar
///
/// Can be used to display Icons that behaves accordingly to a callbackFunction.
class SimpleNavAction extends StatelessWidget {
  final IconData iconData;
  final Function() callbackFunction;
  final Color? iconColor;
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

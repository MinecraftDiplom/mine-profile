import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

enum RiveIcons {
  globe,
  lock,
  gear,
  ribbon,
  search,
  profile,
  network,
  notification,
  location,
  wallet,
  calendar,
  mail,
}

class RiveIcon extends StatelessWidget {
  final RiveIcons icon;
  final double? height;
  final double? width;
  const RiveIcon(this.icon, {super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? 48,
      child: RiveAnimation.asset(
        "assets/animated_icons.riv",
        artboard: icon.name,
      ),
    );
  }
}

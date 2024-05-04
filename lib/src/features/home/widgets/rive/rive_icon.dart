import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/home/models/rive_icons.dart';
import 'package:rive/rive.dart';

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
        'assets/animated_icons.riv',
        artboard: icon.name,
      ),
    );
  }
}

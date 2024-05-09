import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/home/models/rive_icons.dart';
import 'package:rive/rive.dart';

class RiveIcon extends StatelessWidget {
  final RiveIcons icon;
  final double? height;
  final double? width;
  RiveIcon(this.icon,
      {super.key, this.height, this.width, required this.isActive});
  final bool isActive;

  SMIBool? onAnimate;
  StateMachineController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? 48,
      child: RiveAnimation.asset(
        'assets/rive/animated_icons.riv',
        artboard: icon.name,
        onInit: (p0) {
          controller = StateMachineController.fromArtboard(
            p0,
            'State Machine 1',
          )!;
          p0.addController(controller!);
          onAnimate = controller!.findInput<bool>('HOVERED?') as SMIBool;
          onAnimate?.value = isActive;
        },
      ),
    );
  }
}

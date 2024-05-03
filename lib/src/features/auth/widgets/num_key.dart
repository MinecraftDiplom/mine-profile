import 'package:flutter/material.dart';

class NumberKey extends StatelessWidget {
  final String? number;
  final void Function(String value) onPressed;
  final bool background;
  final IconData? icon;

  const NumberKey({
    super.key,
    this.number,
    required this.onPressed,
    this.background = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: background ? Colors.lightBlue.shade200.withAlpha(210) : null,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: MaterialButton(
        onPressed: () => onPressed(number ?? ""),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusColor: Colors.lightBlue.shade200,
        splashColor: Colors.lightBlue.shade200,
        child: number == null
            ? Icon(icon)
            : Text(
                number!,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}

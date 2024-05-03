import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/auth/widgets/num_key.dart';

class NumKeyboard extends StatelessWidget {
  final void Function(String value) onNumPressed;
  final void Function() onClearPressed;
  final void Function() onDeletePressed;

  const NumKeyboard({
    super.key,
    required this.onNumPressed,
    required this.onClearPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberKey(
              number: '1',
              onPressed: (value) => onNumPressed(value),
            ),
            NumberKey(
              number: '2',
              onPressed: (value) => onNumPressed(value),
            ),
            NumberKey(
              number: '3',
              onPressed: (value) => onNumPressed(value),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberKey(
              number: '4',
              onPressed: (value) => onNumPressed(value),
            ),
            NumberKey(
              number: '5',
              onPressed: (value) => onNumPressed(value),
            ),
            NumberKey(
              number: '6',
              onPressed: (value) => onNumPressed(value),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberKey(
              number: '7',
              onPressed: (value) => onNumPressed(value),
            ),
            NumberKey(
              number: '8',
              onPressed: (value) => onNumPressed(value),
            ),
            NumberKey(
              number: '9',
              onPressed: (value) => onNumPressed(value),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberKey(
              icon: Icons.delete,
              background: true,
              onPressed: (value) => onClearPressed(),
            ),
            NumberKey(
              number: '0',
              onPressed: (value) => onNumPressed(value),
            ),
            NumberKey(
              icon: Icons.backspace,
              background: true,
              onPressed: (value) => onDeletePressed(),
            ),
          ],
        ),
      ],
    );
  }
}
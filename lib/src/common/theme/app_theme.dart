import 'dart:io';

import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _buttonPadding = MaterialStatePropertyAll(
    EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 14,
    ),
  );

  static const iconThemeData = IconThemeData(
    applyTextScaling: false,
    size: 20,
  );

  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
      enableFeedback: true,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      splashFactory: Platform.isMacOS || Platform.isIOS
          ? NoSplash.splashFactory
          : InkSparkle.splashFactory,
      elevation: const MaterialStatePropertyAll(0),
      minimumSize: const MaterialStatePropertyAll(Size.zero),
      padding: _buttonPadding,
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonThemeData =
      OutlinedButtonThemeData(
    style: ButtonStyle(
      enableFeedback: true,
      splashFactory: Platform.isMacOS || Platform.isIOS
          ? NoSplash.splashFactory
          : InkSparkle.splashFactory,
      elevation: const MaterialStatePropertyAll(0),
      visualDensity: VisualDensity.comfortable,
      minimumSize: const MaterialStatePropertyAll(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: _buttonPadding,
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    ),
  );

  static FilledButtonThemeData filledButtonThemeData = FilledButtonThemeData(
    style: ButtonStyle(
      enableFeedback: true,
      splashFactory: Platform.isMacOS || Platform.isIOS
          ? NoSplash.splashFactory
          : InkSparkle.splashFactory,
      elevation: const MaterialStatePropertyAll(0),
      visualDensity: VisualDensity.comfortable,
      minimumSize: const MaterialStatePropertyAll(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: _buttonPadding,
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      enableFeedback: true,
      splashFactory: Platform.isMacOS || Platform.isIOS
          ? NoSplash.splashFactory
          : InkSparkle.splashFactory,
      padding: _buttonPadding,
      visualDensity: VisualDensity.comfortable,
      minimumSize: const MaterialStatePropertyAll(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    ),
  );
}

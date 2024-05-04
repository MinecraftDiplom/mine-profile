import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/features/home/models/rive_icons.dart';
import 'package:mine_profile/src/features/home/widgets/rive/rive_icon.dart';
import 'package:mine_profile/src/routes.dart';
import 'package:pinput/pinput.dart';
import 'package:vibration/vibration.dart';

import '../widgets/num_keyboard.dart';

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({super.key, required this.code});
  final String code;
  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onNumPressed(String value) {
    if (controller.text.length < 4) {
      controller.text += value;
    }
  }

  void onClearPressed() {
    if (controller.text.isNotEmpty) {
      controller.clear();
    }
  }

  void onDeletePressed() {
    if (controller.text.isNotEmpty) {
      controller.text = controller.text.substring(0, controller.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => openTelegramPage("https://t.me/MineProfileCodeBot"),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RiveIcon(RiveIcons.notification),
                  SizedBox(width: 8),
                  Text(
                    "Введите код из Telegram-бота",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Pinput(
              onChanged: (value) async {
                if (controller.length == 4 && controller.text == widget.code) {
                  await storage.write(key: "auth", value: "true");
                  context.go(ScreenRoutes.home.path);
                }

                if (controller.length == 4 && controller.text != widget.code) {
                  if (await Vibration.hasVibrator() == true) {
                    Vibration.vibrate();
                  }
                  controller.text = "";
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Неправильный код'),
                      ),
                    );
                }
              },
              pinAnimationType: PinAnimationType.fade,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.lightBlue.shade300,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 239, 243, 1),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              cursor: Container(),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              preFilledWidget: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 65,
                    height: 1,
                  ),
                ],
              ),
              autofocus: true,
              keyboardType: TextInputType.none,
              controller: controller,
            ),
            const Spacer(flex: 2),
            NumKeyboard(
              onNumPressed: onNumPressed,
              onClearPressed: onClearPressed,
              onDeletePressed: onDeletePressed,
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}

// class CodeVerificationScreen extends StatefulWidget {
//   const CodeVerificationScreen({super.key, required this.code});
//   final String code;
//   @override
//   State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
// }
//
// class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
//   String _code = '';
//
//   @override
//   Widget build(BuildContext context) {
//     const storage = FlutterSecureStorage();
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.bottomCenter,
//         padding: EdgeInsets.only(top: 200),
//         child: Column(
//           children: [
//             Text(_code),
//             const Spacer(),
//             Expanded(
//               child: GridView.builder(
//                 reverse: false,
//                 itemCount: 12,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   if (index < 9) {
//                     return TextButton(
//                       onPressed: () async {
//                         if (_code.length < 6) _code += (index + 1).toString();
//                         if (_code.length == 6 && _code == widget.code) {
//                           await storage.write(key: "auth", value: "true");
//                           context.go(ScreenRoutes.home.path);
//                         }
//                         setState(() {});
//                       },
//                       child: Text(
//                         (index + 1).toString(),
//                       ),
//                     );
//                   } else if (index == 10) {
//                     // Delete button
//                     return TextButton(
//                       onPressed: () {
//                         if (_code.length < 6) _code += "0";
//                         if (_code.length == 6 && _code == widget.code) {
//                           context.go(ScreenRoutes.home.path);
//                         }
//                         setState(() {});
//                       },
//                       child: const Text("0"),
//                     );
//                   }
//                   else if (index == 11) {
//                     return IconButton(
//                       icon: const Icon(Icons.backspace),
//                       onPressed: _code.isNotEmpty
//                           ? () {
//                         setState(() {
//                           if (_code.isNotEmpty) {
//                             _code = _code.substring(0, _code.length - 1);
//                           }
//                         });
//                       }
//                           : null,
//                     );
//                   }
//                   else {
//                     return const SizedBox.shrink();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

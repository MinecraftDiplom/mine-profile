import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/blocs/home/home_cubit.dart';
import 'package:mine_profile/src/features/home/models/rive_icons.dart';
import 'package:mine_profile/src/features/home/widgets/rive/rive_icon.dart';

class InputPromoForm extends StatefulWidget {
  const InputPromoForm({super.key, required this.data});
  final UserData data;

  @override
  State<InputPromoForm> createState() => _InputPromoFormState();
}

class _InputPromoFormState extends State<InputPromoForm> {
  var dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();
  final codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: 64,
              keyboardType: TextInputType.visiblePassword,
              focusNode: codeFocusNode,
              controller: codeController,
              decoration: InputDecoration(
                hintText: "Промокод",
                icon: RiveIcon(
                  RiveIcons.ribbon,
                  isActive: true,
                ),
                label: const Text('Promocode'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  codeFocusNode.requestFocus();
                  return "Введите код";
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                var request = await dio.post(
                  "http://kissota.ru:9000/profiles/promo/${widget.data.profile!.id}",
                  data: FormData.fromMap(
                    {
                      "code": codeController.text,
                    },
                  ),
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      var message = switch (status) {
                        200 => null,
                        400 => 'Промокод уже активирован',
                        404 => 'Данный промокод не найден',
                        500 => 'Ошибка со стороны сервера',
                        _ => 'Неизвестная ошибка'
                      };
                      if (message != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      }
                      return true;
                    },
                  ),
                );
                if (request.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(request.data.toString()),
                    ),
                  );
                  context.read<HomeCubit>().updateData();
                }
                setState(() {});
              }
            },
            child: const Text('Активировать промокод'),
          ),
        ],
      ),
    );
  }
}

import 'package:disappear/themes/color_scheme.dart';
import 'package:disappear/themes/text_theme.dart';
import 'package:flutter/material.dart';

class SuccessNewPasswordScreen extends StatelessWidget {
  static const String routePath = '/success-new-password';
  const SuccessNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/success_logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Text('Kata sandi mu sudah berhasil diganti.',
                style: regularBody3.copyWith(
                  color: blackColor,
                ),
                textAlign: TextAlign.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Masuk',
                    style: boldBody3.copyWith(
                      color: primary40,
                    ),
                    textAlign: TextAlign.center),
                Text(', yuk!',
                    style: regularBody3.copyWith(
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

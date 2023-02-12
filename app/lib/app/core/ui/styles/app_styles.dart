import 'package:app/app/core/ui/styles/colors_app.dart';
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static AppStyles? _instance;

  AppStyles._();

  static AppStyles get i {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: ColorsApp.i.primary,
        textStyle: TextStyles.i.textButtonLabel,
      );
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}

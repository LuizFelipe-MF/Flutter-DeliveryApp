import 'package:app/app/core/global/global_context.dart';
import 'package:app/app/core/provider/aplication_binding.dart';
import 'package:app/app/core/ui/styles/app_styles.dart';
import 'package:app/app/core/ui/styles/colors_app.dart';
import 'package:app/app/core/ui/theme/theme_config.dart';
import 'package:app/app/pages/auth/login/login_page.dart';
import 'package:app/app/pages/auth/login/login_router.dart';
import 'package:app/app/pages/auth/register/register_page.dart';
import 'package:app/app/pages/auth/register/register_router.dart';
import 'package:app/app/pages/home/home_router.dart';
import 'package:app/app/pages/order/order_complete_page.dart';
import 'package:app/app/pages/order/order_router.dart';
import 'package:app/app/pages/product_detail/product_detail_page.dart';
import 'package:app/app/pages/product_detail/product_detail_router.dart';
import 'package:app/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class App extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  App({super.key}) {
    GlobalContext.i.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return AplicationBinding(
      child: MaterialApp(
        title: 'Delivery App',
        navigatorKey: _navKey,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletePage(),
        },
        theme: ThemeConfig.theme,
      ),
    );
  }
}

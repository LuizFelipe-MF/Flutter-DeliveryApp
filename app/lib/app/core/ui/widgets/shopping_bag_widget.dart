import 'package:app/app/core/extensions/formatter_extension.dart';
import 'package:app/app/core/ui/helpers/size_extensions.dart';
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:app/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  const ShoppingBagWidget({
    super.key,
    required this.bag,
  });

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final sp = await SharedPreferences.getInstance();

    if (!sp.containsKey('accessToken')) {
      final loginResult = navigator.pushNamed('/auth/login');

      if (loginResult == null || loginResult == false) {
        return;
      }
    }

    await navigator.pushNamed('/order', arguments: bag);
  }

  @override
  Widget build(BuildContext context) {
    var totalBagPrice =
        bag.fold<double>(0.0, (total, e) => total += e.totalPrice).currencyPTBR;

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          _goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_cart_outlined),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Ver Sacola',
                style: context.textStyle.textExtraBold.copyWith(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBagPrice,
                style: context.textStyle.textExtraBold.copyWith(fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }
}

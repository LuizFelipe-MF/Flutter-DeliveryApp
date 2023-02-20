// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/core/extensions/formatter_extension.dart';
import 'package:app/app/core/ui/styles/colors_app.dart';
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:app/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto orderProduct;

  const OrderProductTile({
    super.key,
    required this.index,
    required this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    final product = orderProduct.product;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.network(
            product.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.textStyle.textRegular.copyWith(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (orderProduct.amount * product.price).currencyPTBR,
                        style: context.textStyle.textMedium.copyWith(
                          color: context.colors.secondary,
                          fontSize: 14,
                        ),
                      ),
                      DeliveryIncrementDecrementButton.compact(
                        amount: 1,
                        incrementTap: () {},
                        decrementTap: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

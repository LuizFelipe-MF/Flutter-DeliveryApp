import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:app/app/core/ui/widgets/delivery_button.dart';
import 'package:app/app/dto/order_product_dto.dart';
import 'package:app/app/models/product_model.dart';
import 'package:app/app/pages/order/widget/order_field.dart';
import 'package:app/app/pages/order/widget/order_product_tile.dart';
import 'package:app/app/pages/order/widget/payments_type_field.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  Text(
                    'Carrinho',
                    style: context.textStyle.textTitle,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/trashRegular.png'),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
              (context, index) {
                return Column(
                  children: [
                    OrderProductTile(
                      index: index,
                      orderProduct: OrderProductDto(
                        amount: 10,
                        product: ProductModel.fromMap({}),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do pedido:',
                        style: context.textStyle.textExtraBold
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        r'R$',
                        style: context.textStyle.textExtraBold
                            .copyWith(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                OrderField(
                  title: 'Endereço de entrega:',
                  hintText: 'Digite um endereço',
                  controller: TextEditingController(),
                  validator: Validatorless.required('m'),
                ),
                const SizedBox(
                  height: 10,
                ),
                OrderField(
                  title: 'CPF:',
                  hintText: 'Digite o CPF',
                  controller: TextEditingController(),
                  validator: Validatorless.required('m'),
                ),
                const PaymentsTypeField(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DeliveryButton(
                    width: double.infinity,
                    height: 48,
                    label: 'FINALIZAR',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

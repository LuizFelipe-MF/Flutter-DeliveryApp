import 'package:app/app/core/extensions/formatter_extension.dart';
import 'package:app/app/core/ui/base_state/base_state.dart';
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:app/app/core/ui/widgets/delivery_button.dart';
import 'package:app/app/dto/order_dto.dart';
import 'package:app/app/dto/order_product_dto.dart';
import 'package:app/app/models/payment_types_model.dart';
import 'package:app/app/models/product_model.dart';
import 'package:app/app/pages/order/order_controller.dart';
import 'package:app/app/pages/order/order_state.dart';
import 'package:app/app/pages/order/widget/order_field.dart';
import 'package:app/app/pages/order/widget/order_product_tile.dart';
import 'package:app/app/pages/order/widget/payments_type_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final _formKey = GlobalKey<FormState>();

  final _adressEC = TextEditingController();
  final _documentEC = TextEditingController();
  int? _paymentTypeId;
  final paymentTypeValid = ValueNotifier(true);

  @override
  void onReady() {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;

    controller.load(products);
  }

  void _showConfirmRemoveDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Deseja excluir o produto ${state.orderProduct.product.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.cancelDeleteProcess();
              },
              child: Text(
                'Cancelar',
                style: context.textStyle.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.decrementProduct(state.index);
              },
              child: Text(
                'Confirmar',
                style: context.textStyle.textExtraBold,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage ?? 'Ocorreu um erro inesperado.');
          },
          confirmRemoveProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmRemoveDialog(state);
            }
          },
          emptyBag: () {
            showInfo('Sua sacola está vazia.');
            Navigator.pop(context, <OrderProductDto>[]);
          },
          success: () {
            hideLoader();
            Navigator.of(context).popAndPushNamed(
              '/order/completed',
              result: <OrderProductDto>[],
            );
          },
        );
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppBar(),
          body: Form(
            key: _formKey,
            child: CustomScrollView(
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
                          onPressed: () {
                            controller.emptyBag();
                          },
                          icon: Image.asset('assets/images/trashRegular.png'),
                        )
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                    List<OrderProductDto>>(
                  selector: (state) => state.orderProducts,
                  builder: (context, orderProducts) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: orderProducts.length,
                        (context, index) {
                          final OrderProductDto product = orderProducts[index];
                          return Column(
                            children: [
                              OrderProductTile(
                                index: index,
                                orderProduct: product,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
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
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (context, totalOrder) {
                                return Text(
                                  totalOrder.currencyPTBR,
                                  style: context.textStyle.textExtraBold
                                      .copyWith(fontSize: 20),
                                );
                              },
                            ),
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
                        controller: _adressEC,
                        validator:
                            Validatorless.required('Endereço obrigatório.'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OrderField(
                        title: 'CPF:',
                        hintText: 'Digite o CPF',
                        controller: _documentEC,
                        validator: Validatorless.required('CPF obrigatório.'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypesModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (context, paymentTypes) {
                          return ValueListenableBuilder(
                              valueListenable: paymentTypeValid,
                              builder: (context, paymentTypeValidValue, child) {
                                return PaymentsTypeField(
                                  paymentTypes: paymentTypes,
                                  valueChanged: (value) {
                                    _paymentTypeId = value;
                                  },
                                  valid: paymentTypeValidValue,
                                  valueSelected: _paymentTypeId.toString(),
                                );
                              });
                        },
                      ),
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
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            paymentTypeValid.value = _paymentTypeId != null;

                            if (valid && _paymentTypeId != null) {
                              controller.saveOrder(
                                adress: _adressEC.text,
                                document: _documentEC.text,
                                paymentMethodId: _paymentTypeId!,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

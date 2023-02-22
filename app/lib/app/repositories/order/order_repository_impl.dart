// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/core/exeptions/repository_exeption.dart';
import 'package:app/app/core/rest_client/custom_dio.dart';
import 'package:app/app/dto/order_dto.dart';
import 'package:app/app/models/payment_types_model.dart';
import 'package:dio/dio.dart';

import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypesModel>> getAllPaymentTypes() async {
    try {
      final result = await dio.auth().get('/payment-types');

      return result.data
          .map<PaymentTypesModel>((e) => PaymentTypesModel.fromMap(e))
          .toList();
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao buscar formas de pagamento.');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await dio.auth().post('/orders', data: {
        'products': order.products
            .map((e) => {
                  'id': e.product.id,
                  'amount': e.amount,
                  'totalPrice': e.totalPrice,
                })
            .toList(),
        'user_id': '#userAuthRef',
        'address': order.address,
        'CPF': order.document,
        'payment_method_id': order.paymentMethodId,
      });
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao realizar pedido.'); 
    }
  }
}

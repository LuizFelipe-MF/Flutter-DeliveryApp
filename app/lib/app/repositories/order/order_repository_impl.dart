// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/core/exeptions/repository_exeption.dart';
import 'package:app/app/core/rest_client/custom_dio.dart';
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
    } on DioError {
      throw RepositoryExeption(message: 'Erro ao buscar formas de pagamento.');
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:app/app/core/exeptions/repository_exeption.dart';
import 'package:app/app/core/rest_client/custom_dio.dart';
import 'package:app/app/models/product_model.dart';
import 'package:dio/dio.dart';

import './products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio dio;
  ProductsRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await dio.unauth().get('/products');
      return result.data
          .map<ProductModel>(
            (p) => ProductModel.fromMap(p),
          )
          .toList();
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao buscar produtos!');
    }
  }
}

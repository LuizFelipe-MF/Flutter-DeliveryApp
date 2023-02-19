// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/core/exeptions/repository_exeption.dart';
import 'package:app/app/core/exeptions/unauthorized_exeption.dart';
import 'package:app/app/core/rest_client/custom_dio.dart';
import 'package:app/app/models/auth_model.dart';
import 'package:dio/dio.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;
  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        email: email,
        password: password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw UnauthorizedExeption();
      }

      throw RepositoryExeption(message: 'Erro ao cadastrar usuário.');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users', data: {
        name: name,
        email: email,
        password: password,
      });
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao registrar usuário.');
    }
  }
}

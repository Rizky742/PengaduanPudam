import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pengaduan/core/env.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/core/exception/custom_exception.dart';
import 'package:pengaduan/features/auth/data/models/auth_model.dart';

import 'package:pengaduan/features/auth/domain/entities/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthRemoteDatasource {
  Future<Auth> signIn({
    required String username,
    required String password,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  @override
  Future<AuthModel> signIn(
      {required String username, required String password}) async {
    try {
      String baseUrl = await getBaseUrl();
      var url = Uri.parse("$baseUrl/petugas/login");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'user',
            jsonEncode(
              {
                'username': username,
                'password': password,
              },
            ));
        return AuthModel.fromJson(jsonDecode(response.body)['data']);
      } else if (response.statusCode == 401) {
        throw ServerException('Email atau Password salah');
      } else {
        throw ServerException('Server error');
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure(e.toString());
      } else {
        throw ServerFailure(e.toString());
      }
    }
  }
}

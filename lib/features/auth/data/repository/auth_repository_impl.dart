import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pengaduan/features/auth/domain/entities/auth.dart';
import 'package:pengaduan/features/auth/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, Auth>> signIn(
      {required String username, required String password}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final user =
          await remoteDatasource.signIn(username: username, password: password);
      prefs.setString('profile', jsonEncode(user));
      return Right(user);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}

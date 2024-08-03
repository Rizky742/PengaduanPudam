import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/auth/domain/entities/auth.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Auth>> signIn ({
    required String username,
    required String password,
  });
}

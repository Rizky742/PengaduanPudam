import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pengaduan/features/auth/domain/entities/auth.dart';
import 'package:pengaduan/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, Auth>> signIn(
      {required String username, required String password}) async {
    try {
      final user =
          await remoteDatasource.signIn(username: username, password: password);

      // var box = await Hive.box('UserDataBox');
      // await box.put('data', user);
      // box.put('userData', user);
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

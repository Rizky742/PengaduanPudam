import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/auth/domain/entities/auth.dart';
import 'package:pengaduan/features/auth/domain/repository/auth_repository.dart';

class SignIn {
  final AuthRepository authRepository;

  SignIn(this.authRepository);

  Future<Either<Failure, Auth>> call({
    required String username,
    required String password,
  }) async {
    return await authRepository.signIn(username: username, password: password);
  }
}

import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/data/datasources/pengaduan_remote_datasource.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class PengaduanRepositoryImpl implements PengaduanRepository {
  final PengaduanRemoteDatasource remoteDatasource;

  PengaduanRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Pengaduan>>> getPengaduan(
      {required String month,
      required String year,
      required String role,
      required String id}) async {
    try {
      final periode = await remoteDatasource.getPengaduan(
          month: month, year: year, id: id, role: role);
      // print(periode);
      return right(periode);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Petugas>>> getPetugas(
      {required String divisiId}) async {
    try {
      final petugas = await remoteDatasource.getPetugas(divisiId: divisiId);
      return right(petugas);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }
}

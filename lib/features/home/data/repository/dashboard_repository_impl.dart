import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/home/data/datasources/dashboard_remote_datasource.dart';
import 'package:pengaduan/features/home/domain/entities/dashboard.dart';
import 'package:pengaduan/features/home/domain/entities/periode.dart';
import 'package:pengaduan/features/home/domain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource remoteDatasource;
  DashboardRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, Dashboard>> getDashboardByPeriode(
      {required String month, required String year}) async {
    try {
      final dashboard = await remoteDatasource.getDashboardByPeriode(
          month: month, year: year);
      return right(dashboard);
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
  Future<Either<Failure, List<Periode>>> getPeriode() async{
    try {
      final periode = await remoteDatasource.getPeriode();
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
}

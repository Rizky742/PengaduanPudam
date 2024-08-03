import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/home/domain/entities/dashboard.dart';
import 'package:pengaduan/features/home/domain/repository/dashboard_repository.dart';

class GetDashboardByPeriode {
  final DashboardRepository dashboardRepository;

  GetDashboardByPeriode(this.dashboardRepository);

  Future<Either<Failure, Dashboard>> call({
    required String month,
    required String year,
  }) async {
    return await dashboardRepository.getDashboardByPeriode(
        month: month, year: year);
  }
}
